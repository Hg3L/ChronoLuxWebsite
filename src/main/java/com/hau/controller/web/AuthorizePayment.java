package com.hau.controller.web;

import com.hau.constant.SystemConstant;
import com.hau.dto.*;
import com.hau.service.*;
import com.hau.service.impl.PaymentServices;
import com.hau.util.CartUtils;
import com.paypal.api.payments.*;
import com.paypal.base.rest.PayPalRESTException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.bind.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
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
                                        HttpServletResponse response){
        ModelAndView mav = new ModelAndView();

        try{
            UserDTO userDTO = null;
            List<ProductDTO> productDTOList = productService.findAll();
            String txt = "";
            CartDTO cartDTO = CartUtils.getCartByCookieAndDeleteCookie(request.getCookies(), productDTOList,txt,response);

            if(authentication != null){
                userDTO = userService.getCurrentLoggedInCustomer(authentication);
            }
            CartUtils.DeleteCartItemByAuthentication(userDTO,cartDTO,txt,response);
            ////
            PaymentServices paymentServices = new PaymentServices();
            Payment payment = paymentServices.getPaymentDetails(paymentId);
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

            mav = new ModelAndView("redirect:/checkout/success");

        } catch (PayPalRESTException ex){
            ex.printStackTrace();
            mav = new ModelAndView("redirect:/checkout") ;

        }

        return mav;
    }
}
