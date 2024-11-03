package com.hau.controller.web;

import com.hau.config.VNPayConfig;
import com.hau.constant.SystemConstant;
import com.hau.dto.*;
import com.hau.service.*;
import com.hau.util.CartUtils;
import org.apache.http.HttpRequest;
import org.apache.http.client.fluent.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.bind.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

import static com.hau.config.VNPayConfig.*;

@Controller
public class PaymentVNPayController {
    @Autowired
    private BillService billService;
    @Autowired
    private CartItemService cartItemService;
    @Autowired
    private UserService userService;
    @Autowired
    private ProductService productService;
    @Autowired
    private JavaMailSender mailSender;
    @Autowired
    private CurrencyFormat currencyFormat;
    @GetMapping("/payment/create-payment")
    public String createPayment(HttpServletRequest request,
                                @ModelAttribute BillDTO billDTO) throws UnsupportedEncodingException {

        HttpSession session = request.getSession();
        session.setAttribute("bill", billDTO);
        String approvalLink = null;

       // long amount = Integer.parseInt(req.getParameter("amount"))*100;
      //  String bankCode = req.getParameter("bankCode");
        Double total = billDTO.getTotal() * 100;
        long amount = total.longValue();
        String vnp_TxnRef = VNPayConfig.getRandomNumber(8);
       // String vnp_IpAddr = VNPayConfig.getIpAddress(req);
        String vnp_IpAddr = VNPayConfig.getIpAddress(request);
        String vnp_TmnCode = VNPayConfig.vnp_TmnCode;

        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
        vnp_Params.put("vnp_OrderType", orderType);
        vnp_Params.put("vnp_Locale", "vn");

        vnp_Params.put("vnp_ReturnUrl", VNPayConfig.vnp_ReturnUrl); // set trang tra ve sau khi thanh toan
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

        List fieldNames = new ArrayList(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        Iterator itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = (String) itr.next();
            String fieldValue = (String) vnp_Params.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                //Build hash data
                hashData.append(fieldName);
                hashData.append('=');
                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                //Build query
                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                query.append('=');
                query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                if (itr.hasNext()) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }
        String queryUrl = query.toString();
        String vnp_SecureHash = VNPayConfig.hmacSHA512(VNPayConfig.secretKey, hashData.toString());
        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
        String paymentUrl = VNPayConfig.vnp_PayUrl + "?" + queryUrl;

        return "redirect:"+paymentUrl;
    }

    @GetMapping("/payment/execute-payment")
    public String CheckoutSuccess(HttpServletRequest request,
                                  @AuthenticationPrincipal Authentication authentication,
                                  HttpServletResponse response) throws UnsupportedEncodingException {
        UserDTO userDTO = null;
        HttpSession session = request.getSession();
        Map<String, String> fields = new HashMap<>();
        for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements();) {
            String fieldName = URLEncoder.encode(params.nextElement(), StandardCharsets.US_ASCII.toString());
            String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
            if (fieldValue != null && fieldValue.length() > 0) {
                fields.put(fieldName, fieldValue);
            }
        }

        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
        fields.remove("vnp_SecureHashType");
        fields.remove("vnp_SecureHash");

        // Check checksum
        String signValue = VNPayConfig.hashAllFields(fields);

        if (signValue.equals(vnp_SecureHash)) {
            if ("00".equals(request.getParameter("vnp_ResponseCode"))) {

                BillDTO billDTO = (BillDTO) session.getAttribute("bill");
                List<ProductDTO> productDTOList = productService.findAll();
                String txt = "";
                CartDTO cartDTO = CartUtils.getCartByCookie(request.getCookies(), productDTOList);
                billDTO.setCartItemDTOS(CartUtils.getCartItemByAuthentication(cartDTO,userDTO));
                billDTO.setStatus(SystemConstant.PAYMENT_SUCCESS);
                if(authentication != null){
                    userDTO = userService.getCurrentLoggedInCustomer(authentication);
                    billDTO.setUsername(userDTO.getUserName());
                }
                else {
                    billDTO.setUsername(null);
                }
                CartUtils.DeleteCartItemByAuthentication(userDTO,cartDTO,txt,response);
                billService.save(billDTO);
                session.removeAttribute("bill");
                return "redirect:/checkout/success";
            } else if("24".equals(request.getParameter("vnp_ResponseCode")) ) {
                session.removeAttribute("bill");
                return "redirect:/cart";
            }

        } else {
            System.out.print("Chu ky khong hop le");
            session.removeAttribute("bill");
            return "redirect:/cart";
        }
        return "redirect:/cart";
    }

    @PostMapping("/vnpay/ipn")
    public String handleIpn(HttpServletRequest request) {
        try {
            Map<String, String> fields = new HashMap<>();
            for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = URLEncoder.encode(params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if (fieldValue != null && fieldValue.length() > 0) {
                    fields.put(fieldName, fieldValue);
                }
            }

            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            fields.remove("vnp_SecureHashType");
            fields.remove("vnp_SecureHash");

            // Check checksum
            String signValue = VNPayConfig.hashAllFields(fields);
            if (signValue.equals(vnp_SecureHash)) {
                boolean checkOrderId = true; // Kiểm tra mã giao dịch tồn tại trong cơ sở dữ liệu
                boolean checkAmount = true; // Kiểm tra số tiền
                boolean checkOrderStatus = true; // Kiểm tra trạng thái đơn hàng

                if (checkOrderId) {
                    if (checkAmount) {
                        if (checkOrderStatus) {
                            if ("00".equals(request.getParameter("vnp_ResponseCode"))) {
                                // Cập nhật trạng thái thanh toán thành công vào cơ sở dữ liệu
                                // yourDatabaseService.updatePaymentStatus(...);
                                return "{\"RspCode\":\"00\",\"Message\":\"Confirm Success\"}";
                            } else {
                                // Cập nhật trạng thái thanh toán thất bại vào cơ sở dữ liệu
                                // yourDatabaseService.updatePaymentStatus(...);
                                return "{\"RspCode\":\"02\",\"Message\":\"Payment Failed\"}";
                            }
                        } else {
                            return "{\"RspCode\":\"02\",\"Message\":\"Order already confirmed\"}";
                        }
                    } else {
                        return "{\"RspCode\":\"04\",\"Message\":\"Invalid Amount\"}";
                    }
                } else {
                    return "{\"RspCode\":\"01\",\"Message\":\"Order not Found\"}";
                }
            } else {
                return "{\"RspCode\":\"97\",\"Message\":\"Invalid Checksum\"}";
            }
        } catch (Exception e) {
            return "{\"RspCode\":\"99\",\"Message\":\"Unknown error\"}";
        }
    }

    public void sendEmail(String email , List<CartItemDTO> cartItemDTOS, BillDTO billDTO) throws MessagingException, UnsupportedEncodingException {
        // Tạo đối tượng MimeMessage
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

// Thiết lập thông tin người gửi và người nhận
        helper.setFrom("contact@chronolux.com", "ChronoLux Support");
        helper.setTo(email);
        helper.setSubject("Chúc mừng bạn đã đặt hàng thành công!");


// Nội dung email với CSS để thiết kế các ô sản phẩm và tổng cộng
        StringBuilder content = new StringBuilder("<p style='font-family: Arial, sans-serif; color: #333; margin: 20px; font-size: 28px;'><strong>Thông tin đơn hàng:</strong></p>");

// Sử dụng vòng lặp để thêm từng sản phẩm vào nội dung email
        String productIndex1 = "1";
        for (CartItemDTO product : cartItemDTOS) {
            String productName = product.getProductName();
            String productDescription = product.getProductType();
            double productPrice =  Double.parseDouble(product.getProductPrice()) ;
            int productQuantity = Integer.parseInt(product.getQuantity()) ;
            String imageUrl = product.getProductImgUrl();

            content.append("<div style='border: 1px solid #ccc; border-radius: 5px; padding: 10px; margin: 10px 0; display: flex; align-items: flex-start;'>")
                    .append("<img src='cid:productImage").append(productIndex1).append("' alt='Product Image' style='width: 80px; height: 100px; border: 1px solid #ccc; border-radius: 5px; margin-right: 10px;'/>")
                    .append("<div style='flex-grow: 1;'>")
                    .append("<h1 style='color: #007BFF; font-size: 18px; margin: 0;'>").append(productName).append("</h1>")
                    .append("<p style='margin: 5px 0;'><strong>Mô tả:</strong> ").append(productDescription).append("</p>")
                    .append("<p style='margin: 5px 0;'><strong>Giá:</strong> ").append(currencyFormat.formatCurrency(productPrice) ).append("</p>")
                    .append("<p style='margin: 5px 0;'><strong>Số lượng:</strong> ").append(productQuantity).append("</p>")
                    .append("</div></div>");
            productIndex1 = String.valueOf (Integer.parseInt(productIndex1) +1);
        }

// Phần tổng cộng
        // Thông tin khách hàng
        content.append("<div style='text-align: right; margin-top: 20px;'>")
                .append("<p style='font-weight: bold; font-size: 16px;'>Tổng giá trị sản phẩm: ").append(currencyFormat.formatCurrency(billDTO.getSubtotal()) ).append("</p>")
                .append("<p style='font-weight: bold; font-size: 16px;'>Khuyến mãi: ").append(currencyFormat.formatCurrency(billDTO.getDiscount()) ).append("</p>")
                .append("<p style='font-weight: bold; font-size: 16px;'>Tổng cộng: ").append(currencyFormat.formatCurrency(billDTO.getTotal()) ).append("</p>")
                .append("</div>")

// Thông tin khách hàng
                .append("<div style='border-top: 1px solid #ccc; padding-top: 10px; margin-top: 20px;'>")
                .append("<h2 style='font-family: Arial, sans-serif; color: #333; font-size: 16px;'>Thông tin khách hàng</h2>")
                .append("<p><strong>Họ và tên:</strong> ").append(billDTO.getDisplayName()).append("</p>")
                .append("<p><strong>Email:</strong> ").append(billDTO.getEmail()).append("</p>")
                .append("<p><strong>Số điện thoại:</strong> ").append(billDTO.getPhone()).append("</p>")
                .append("<p><strong>Địa chỉ:</strong> ").append(billDTO.getStreet()).append("-").append(billDTO.getWard()).append("-").append(billDTO.getDistrict()).append("-").append(billDTO.getCity()).append("</p>")
                .append("</div>");


// Thiết lập nội dung email
        helper.setText(content.toString(), true);
        String productIndex2 = "1";
        for(CartItemDTO product : cartItemDTOS){
            FileSystemResource image = new FileSystemResource(new File("D:\\Java\\ChronoLux-Web-Project\\ChronoLuxWeb\\src\\main\\webapp\\template\\web\\img\\products\\"+product.getProductImgUrl() ));
            helper.addInline("productImage" + productIndex2, image, "image/webp");
            productIndex2 = String.valueOf (Integer.parseInt(productIndex2) +1);
        }

// Gửi email
        mailSender.send(message);
    }

}
