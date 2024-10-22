package com.hau.controller.web;

import com.hau.dto.CartItemDTO;
import com.hau.service.impl.PaymentServices;
import com.paypal.api.payments.Payment;
import com.paypal.base.rest.PayPalRESTException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
public class AuthorizePayment {
    @PostMapping("/authorize_payment")
    public ModelAndView authorizePayment(@ModelAttribute CartItemDTO cartItemDTO, HttpServletRequest request, HttpServletResponse response) throws IOException {
        CartItemDTO cartItem = new CartItemDTO(cartItemDTO.getProductName(),cartItemDTO.getSubtotal(),cartItemDTO.getTotal(),cartItemDTO.getQuantity());
        ModelAndView mav = new ModelAndView();
        try{
            PaymentServices paymentServices = new PaymentServices();
            String approvalLink = paymentServices.authorizePayment(cartItem,request);
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
    public String ExecutePayment(@RequestParam("paymentId") String paymentId,
                                 @RequestParam("payerId") String payerId){
        String view = "";
        try{
            PaymentServices paymentServices = new PaymentServices();
            Payment payment =  paymentServices.executePayment(paymentId,payerId);
            view = "redirect:/checkout/success";
        } catch (PayPalRESTException ex){
            ex.printStackTrace();
            view = "redirect:/checkout";

        }

        return view;
    }
}
