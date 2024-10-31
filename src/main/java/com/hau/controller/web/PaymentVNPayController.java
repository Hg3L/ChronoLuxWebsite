package com.hau.controller.web;

import com.hau.config.VNPayConfig;
import com.hau.constant.SystemConstant;
import com.hau.dto.BillDTO;
import com.hau.dto.CartDTO;
import com.hau.dto.ProductDTO;
import com.hau.dto.UserDTO;
import com.hau.service.BillService;
import com.hau.service.CartItemService;
import com.hau.service.ProductService;
import com.hau.service.UserService;
import com.hau.util.CartUtils;
import org.apache.http.HttpRequest;
import org.apache.http.client.fluent.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.bind.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
            System.out.println("Fields: " + fields);
            System.out.println("vnp_SecureHash: " + vnp_SecureHash);
            System.out.println("Calculated signValue: " + signValue);
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
}
