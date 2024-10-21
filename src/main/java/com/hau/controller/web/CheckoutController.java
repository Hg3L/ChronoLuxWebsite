package com.hau.controller.web;

import com.hau.dto.UserDTO;
import com.hau.service.CartItemService;
import com.hau.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.bind.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
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
}
