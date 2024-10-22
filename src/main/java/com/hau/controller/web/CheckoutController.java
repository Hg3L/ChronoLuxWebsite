package com.hau.controller.web;

import com.hau.dto.UserDTO;
import com.hau.service.CartItemService;
import com.hau.service.UserService;
import com.hau.service.impl.PaymentServices;
import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.ShippingAddress;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.PayPalRESTException;
import org.dom4j.rule.Mode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.method.P;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.bind.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CheckoutController {
    @Autowired
    private UserService userService;
    @Autowired
    private CartItemService cartItemService;
    @RequestMapping(value = "/checkout", method = RequestMethod.GET)
    public ModelAndView checkoutPage(@RequestParam("subtotal") long subtotal,
                                     @RequestParam( value = "discount",required = false) Double discount,
                                     @RequestParam("total") double total,
                                     @AuthenticationPrincipal Authentication authentication) {
        UserDTO userDTO = userService.getCurrentLoggedInCustomer(authentication);
        ModelAndView mav = new ModelAndView("web/checkout");
        mav.addObject("subtotal",subtotal);
        mav.addObject("discount",discount);
        mav.addObject("total",total);
        mav.addObject("cartItems",  cartItemService.findAllByUser(userDTO));
        return mav;
    }

    @GetMapping("/checkout/review")
    public ModelAndView ReviewPayment(@RequestParam("paymentId") String paymentId,
                                      @RequestParam("PayerID") String payerId){
        ModelAndView mav = new ModelAndView();
        try{
            PaymentServices paymentServices = new PaymentServices();
            Payment payment = paymentServices.getPaymentDetails(paymentId);
            PayerInfo payerInfo = payment.getPayer().getPayerInfo();
            Transaction transaction = payment.getTransactions().get(0);
            ShippingAddress shippingAddress = transaction.getItemList().getShippingAddress();
            mav = new ModelAndView("web/checkout-review");
            mav.addObject("paymentId",paymentId);
            mav.addObject("payerId",payerId);
            mav.addObject("payer",payerInfo);
            mav.addObject("transaction",transaction);
            mav.addObject("shippingAddress",shippingAddress);


        }catch (PayPalRESTException ex){
                ex.printStackTrace();
                mav = new ModelAndView("web/checkout");
                mav.addObject("error","Could not get payment details");
        }
        return mav;
    }

    @GetMapping("/checkout/success")
    public String CheckoutSuccess(){
        return "web/checkout-success";
    }

}
