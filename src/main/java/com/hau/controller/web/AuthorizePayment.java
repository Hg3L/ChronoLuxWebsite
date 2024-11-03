package com.hau.controller.web;

import com.hau.constant.SystemConstant;
import com.hau.dto.*;
import com.hau.service.*;
import com.hau.service.impl.PaymentServices;
import com.hau.util.CartUtils;
import com.paypal.api.payments.*;
import com.paypal.base.rest.PayPalRESTException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.bind.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

@Controller
public class AuthorizePayment {
    @Autowired
    private CartItemService cartItemService;
    @Autowired
    private UserService userService;
    @Autowired
    private BillService billService;
    @Autowired
    private ProductService productService;
    @Autowired
    private VoucherService voucherService;
    @Autowired
    private JavaMailSender mailSender;
    @Autowired
    private CurrencyFormat currencyFormat;
    @PostMapping("/authorize_payment")
    public ModelAndView authorizePayment(@ModelAttribute CartItemDTO cartItemDTO, HttpServletRequest request,
                                         @AuthenticationPrincipal Authentication authentication
                                         ) throws IOException {


        UserDTO userDTO = null;
        List<CartItemDTO> cartItemDTOS = new ArrayList<>();
        List<ProductDTO> productDTOList = productService.findAll();
        CartDTO cartDTO = CartUtils.getCartByCookie(request.getCookies(), productDTOList);

        //
        if(authentication != null){
            userDTO = userService.getCurrentLoggedInCustomer(authentication);
        }
        cartItemDTOS =  CartUtils.getCartItemByAuthentication(cartDTO,userDTO);
        ModelAndView mav = new ModelAndView();
        try{
            PaymentServices paymentServices = new PaymentServices();

            String approvalLink = paymentServices.authorizePayment(cartItemDTOS,cartItemDTO,request);
            mav = new ModelAndView("redirect:"+approvalLink);

        }
        catch (PayPalRESTException ex){
            ex.printStackTrace();
            mav = new ModelAndView("redirect:/checkout");
            mav.addObject("error","Invalid Payment Details");
        }
        return mav;
    }
    @PostMapping("/execute_payment")
    public ModelAndView ExecutePayment (@RequestParam("paymentId") String paymentId,
                                        @RequestParam("PayerID") String payerId,
                                        @AuthenticationPrincipal Authentication authentication,
                                        HttpServletRequest request,
                                        HttpServletResponse response) throws MessagingException, UnsupportedEncodingException {
        ModelAndView mav = new ModelAndView();

        try{
            UserDTO userDTO = null;
            List<ProductDTO> productDTOList = productService.findAll();
            String txt = "";
            CartDTO cartDTO = CartUtils.getCartByCookieAndDeleteCookie(request.getCookies(), productDTOList,txt,response);

            if(authentication != null){
                userDTO = userService.getCurrentLoggedInCustomer(authentication);
            }

            ////
            PaymentServices paymentServices = new PaymentServices();
            Payment payment =     paymentServices.executePayment(paymentId,payerId);;
            PayerInfo payerInfo = payment.getPayer().getPayerInfo();
            Transaction transaction = payment.getTransactions().getFirst();
            ShippingAddress shippingAddress = transaction.getItemList().getShippingAddress();
            Amount amount = transaction.getAmount();

            BillDTO billDTO = new BillDTO();
            billDTO.setStreet(shippingAddress.getLine1());
            billDTO.setWard(shippingAddress.getCity());
            billDTO.setDistrict(shippingAddress.getState());
            billDTO.setCity(shippingAddress.getCountryCode());
            billDTO.setEmail(payerInfo.getEmail());
            billDTO.setStatus(SystemConstant.PAYMENT_SUCCESS);
            billDTO.setPhone(payerInfo.getPhone());
            billDTO.setDisplayName(payerInfo.getLastName() +" "+ payerInfo.getFirstName());
            if(authentication != null){
                userDTO = userService.getCurrentLoggedInCustomer(authentication);
                billDTO.setUsername(userDTO.getUserName());
            }
            else {
                billDTO.setUsername(null);
            }

            double subtotal =  Double.parseDouble(amount.getDetails().getSubtotal()) * 24000;
            double total = Double.parseDouble(amount.getTotal()) * 24000;


            billDTO.setSubtotal(subtotal);
            List<CartItemDTO> cartItemDTOS = new ArrayList<>();
            for(Item item : transaction.getItemList().getItems()){
               CartItemDTO cartItemDTO = new CartItemDTO();
               cartItemDTO.setQuantity ( Integer.parseInt(item.getQuantity()));
               if(userDTO != null) {
                   cartItemDTO.setUsername(userDTO.getUserName());
               }
               cartItemDTO.setProductName(item.getName());
               cartItemDTOS.add(cartItemDTO);
            }
            billDTO.setPaymentMethod(SystemConstant.PAYMENT_METHOD_PAYPAL);
            billDTO.setTotal(total);

            billDTO.setCartItemDTOS(cartItemDTOS);

            billService.save(billDTO);
                sendEmail(billDTO.getEmail(),CartUtils.getCartItemByAuthentication(cartDTO,userDTO),billDTO);
            CartUtils.DeleteCartItemByAuthentication(userDTO,cartDTO,txt,response);
            mav = new ModelAndView("redirect:/checkout/success");

        } catch (PayPalRESTException ex){
            ex.printStackTrace();
            mav = new ModelAndView("redirect:/checkout") ;

        }

        return mav;
    }
    public void sendEmail(String email , List<CartItemDTO> cartItemDTOS,BillDTO billDTO) throws MessagingException, UnsupportedEncodingException {
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
            FileSystemResource image = new FileSystemResource(new File("./template/web/img/products/" + product.getProductImgUrl()));
            helper.addInline("productImage" + productIndex2, image, "image/webp");
            productIndex2 = String.valueOf (Integer.parseInt(productIndex2) +1);
        }

// Gửi email
        mailSender.send(message);
    }
}
