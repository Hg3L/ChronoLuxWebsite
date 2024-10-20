package com.hau.controller.web;

import com.hau.dto.UserDTO;
import com.hau.dto.VoucherDTO;
import com.hau.entity.VoucherEntity;
import com.hau.service.CartItemService;
import com.hau.service.IUserService;
import com.hau.service.VoucherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.bind.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CartController {
    @Autowired
    private CartItemService cartItemService;
    @Autowired
    private IUserService userService;
    @Autowired
    private VoucherService voucherService;
    @RequestMapping(value = "/cart", method = RequestMethod.GET)
    public ModelAndView cartPage(@AuthenticationPrincipal Authentication authentication,
                                 @RequestParam(value = "code",required = false) String code) {

        ModelAndView mav = new ModelAndView("web/cart");
        UserDTO userDTO = userService.getCurrentLoggedInCustomer(authentication);
        mav.addObject("cartItems",cartItemService.findAllByUser(userDTO));
        mav.addObject("totalPrice",cartItemService.getTotalPrice(userDTO));
        mav.addObject("voucher",voucherService.findOneByCode(code));
        return mav;
    }
    @PostMapping("/cart")
    public String addToCart(@RequestParam("productId") long productId,
                            @RequestParam("quantity") int quantity,
                            @AuthenticationPrincipal Authentication authentication){
        if(authentication == null || authentication instanceof AnonymousAuthenticationToken){
            return "redirect:/login";
        }

        UserDTO userDTO = userService.getCurrentLoggedInCustomer(authentication);

        cartItemService.save(userDTO,productId,quantity);
        return "redirect:/cart";
    }
    @GetMapping("/cart/update")
    public String updateQuantityCart(@RequestParam("productId") long productId,
                                     @RequestParam("quantity") int quantity,
                                     @AuthenticationPrincipal Authentication authentication){
        UserDTO userDTO = userService.getCurrentLoggedInCustomer(authentication);
        cartItemService.updateQuantity(userDTO,productId,quantity);
        return "redirect:/cart";
    }
    @GetMapping("/cart/del")
    public String deleleCart(@RequestParam("productId") long productId,
                             @AuthenticationPrincipal Authentication authentication){
        UserDTO userDTO = userService.getCurrentLoggedInCustomer(authentication);
        cartItemService.delete(userDTO,productId);

        return "redirect:/cart";
    }

}
