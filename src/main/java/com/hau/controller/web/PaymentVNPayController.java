package com.hau.controller.web;

import com.hau.config.VNPayConfig;
import com.hau.constant.SystemConstant;
import com.hau.dto.*;
import com.hau.service.*;
import com.hau.service.impl.PaymentVnpayService;
import com.hau.util.CartUtils;
import com.paypal.api.payments.Payment;
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
    @Autowired
    private PaymentVnpayService paymentVnpayService;
    @GetMapping("/payment/create-payment")
    public String createPayment(HttpServletRequest request,
                                @ModelAttribute BillDTO billDTO) throws UnsupportedEncodingException {
        String paymentUrl = paymentVnpayService.createPayMent(request,billDTO);
        return "redirect:"+paymentUrl;
    }

    @GetMapping("/payment/execute-payment")
    public String CheckoutSuccess(HttpServletRequest request,
                                  @AuthenticationPrincipal Authentication authentication,
                                  HttpServletResponse response) throws UnsupportedEncodingException, MessagingException {
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
                List<ProductDTO> productDTOList = productService.findAllByActive(true);
                String txt = "";

                if(authentication != null){
                    userDTO = userService.getCurrentLoggedInCustomer(authentication);
                    billDTO.setUsername(userDTO.getUserName());
                }
                else {
                    billDTO.setUsername(null);
                }
                // dat duoi username
                CartDTO cartDTO = CartUtils.getCartByCookieAndDeleteCookie(request.getCookies(), productDTOList,txt,response);
                billDTO.setCartItemDTOS(CartUtils.getCartItemByAuthentication(cartDTO,userDTO));
                //
                billDTO.setStatus(SystemConstant.PAYMENT_SUCCESS);
                billService.save(billDTO);
                sendEmail(billDTO.getEmail(),billDTO.getCartItemDTOS(),billDTO);
                CartUtils.DeleteCartItemByAuthentication(userDTO,cartDTO,txt,response);
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
                    .append("<p style='margin: 5px 0;'><strong>Loại máy:</strong> ").append(productDescription).append("</p>")
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
            FileSystemResource image = new FileSystemResource(new File("./template/web/img/products/"+product.getProductImgUrl() ));
            helper.addInline("productImage" + productIndex2, image, "image/webp");
            productIndex2 = String.valueOf (Integer.parseInt(productIndex2) +1);
        }

// Gửi email
        mailSender.send(message);
    }

}
