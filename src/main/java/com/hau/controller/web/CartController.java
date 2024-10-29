package com.hau.controller.web;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hau.dto.CartDTO;
import com.hau.dto.CartItemDTO;
import com.hau.dto.ProductDTO;
import com.hau.dto.UserDTO;
import com.hau.service.CartItemService;
import com.hau.service.ProductService;
import com.hau.service.UserService;
import com.hau.service.VoucherService;
import com.hau.util.CartUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.bind.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@Controller
public class CartController {
    @Autowired
    private CartItemService cartItemService;
    @Autowired
    private UserService userService;
    @Autowired
    private VoucherService voucherService;
    @Autowired
    private ProductService productService;
    @RequestMapping(value = "/cart", method = RequestMethod.GET)
    public ModelAndView cartPage(@AuthenticationPrincipal Authentication authentication,
                                 @RequestParam(value = "code",required = false) String code,
                                 HttpServletRequest request,
                                 HttpServletResponse response) {
        String txt = "";
        ModelAndView mav = new ModelAndView("web/cart");
        UserDTO userDTO = null;
        List<CartItemDTO> cartItemDTOS = new ArrayList<>();
        List<ProductDTO> productDTOList = productService.findAll();
        CartDTO cartDTO = CartUtils.getCartByCookieAndDeleteCookie(request.getCookies(), productDTOList,txt,response);

        //
        if(authentication != null){
            userDTO = userService.getCurrentLoggedInCustomer(authentication);
        }
        String error = null;
            for(CartItemDTO cartItem : cartDTO.getCartItemDTOS()){
                    if(cartItem.getProductQuantity() < Integer.parseInt(cartItem.getQuantity())){
                        cartItem.setQuantity(cartItem.getProductQuantity());
                        error = "Số lượng bạn chọn đã đặt mức tối đa của sản phẩm này";
                    }
                    if(Integer.parseInt(cartItem.getQuantity()) != 0){
                        cartItemDTOS.add(cartItem);
                    }

            }



        List<CartItemDTO> items = cartItemDTOS;
        if(items.size()>0){
            txt = items.get(0).getUsername()+":"+items.get(0).getProductId()+":"+ items.get(0).getQuantity();
            for(int i = 1 ; i<items.size(); i++) {
                txt += "|" +items.get(i).getUsername() +":"+items.get(i).getProductId() +":"+ items.get(i).getQuantity();
            }
        }
        Cookie c  = new Cookie("cart",txt);
        c.setMaxAge(2*24*60*60);
        c.setPath("/ChronoLuxWeb");
        response.addCookie(c);

        CartDTO cartDTO1 = CartUtils.getCartByCookie(request.getCookies(), productDTOList);
        cartItemDTOS = CartUtils.getCartItemByAuthentication(cartDTO1,userDTO);
        mav.addObject("error",error);
        mav.addObject("cartItems",cartItemDTOS);
        mav.addObject("totalPrice",cartDTO.getTotalByUser(userDTO));
        mav.addObject("voucher",voucherService.findOneByCode(code));
        return mav;
    }
    @PostMapping("/cart")
    public String addToCart(@RequestParam("productId") long productId,
                            @RequestParam("quantity") int quantity,
                            @AuthenticationPrincipal Authentication authentication,
                            HttpServletResponse response,
                            HttpServletRequest request,
                            Model model){
        UserDTO userDTO =  new UserDTO();
        if(authentication != null){
           userDTO  = userService.getCurrentLoggedInCustomer(authentication);
        }

        String txt = "";
        Cookie [] arr = request.getCookies();

        if(arr != null){
            for(Cookie o : arr){
                if(o.getName().equals("cart")){
                    txt = o.getValue();
                    o.setMaxAge(0);
                    response.addCookie(o);
                }
            }
        }

        if(txt.isEmpty()){
            txt = userDTO.getUserName()+":"+productId+":"+quantity;
        }else {
            txt = txt + "|"+userDTO.getUserName()+":"+productId+":"+quantity;
        }
            Cookie c = new Cookie("cart",txt);
            c.setMaxAge(2*24*60*60);
            response.addCookie(c);

        return "redirect:/cart";
    }
    @GetMapping("/cart/update")
    public String updateQuantityCart(@RequestParam("productId") long productId,
                                     @RequestParam("quantity") int quantity,
                                     @AuthenticationPrincipal Authentication authentication,
                                     HttpServletResponse response,
                                     HttpServletRequest request){
        UserDTO userDTO;
        List<ProductDTO> productDTOList = productService.findAll();
        String txt = "";
        CartDTO cartDTO = CartUtils.getCartByCookieAndDeleteCookie(request.getCookies(), productDTOList,txt,response);
        if(authentication != null){
            userDTO = userService.getCurrentLoggedInCustomer(authentication);
            for(CartItemDTO cartItemDTO : cartDTO.getCartItemDTOS()){
                if((cartItemDTO.getUsername().equals(userDTO.getUserName())) && cartItemDTO.getProductId() == productId){
                    if(quantity < 1){
                        cartItemDTO.setQuantity(1);
                    }
                    else{
                        cartItemDTO.setQuantity(quantity);
                    }

                }
            }
        } else {
            for(CartItemDTO cartItemDTO : cartDTO.getCartItemDTOS()){
                if((cartItemDTO.getUsername().equals("null")) && cartItemDTO.getProductId() == productId){
                    if(quantity < 1){
                        cartItemDTO.setQuantity(1);
                    }
                    else{
                        cartItemDTO.setQuantity(quantity);
                    }
                }
            }
        }
        List<CartItemDTO> items = cartDTO.getCartItemDTOS();
        txt = "";
        if(items.size()>0){
            txt = items.get(0).getUsername()+":"+items.get(0).getProductId()+":"+ items.get(0).getQuantity();
            for(int i = 1 ; i<items.size(); i++) {
                txt += "|" +items.get(i).getUsername() +":"+items.get(i).getProductId() +":"+ items.get(i).getQuantity();
            }
        }
        Cookie c  = new Cookie("cart",txt);
        c.setMaxAge(2*24*60*60);
        c.setPath("/ChronoLuxWeb");
        response.addCookie(c);
        return "redirect:/cart";
    }
    @GetMapping("/cart/del")
    public String deleleCart(@RequestParam("productId") long productId,
                             @AuthenticationPrincipal Authentication authentication,
                             HttpServletRequest request,
                             HttpServletResponse response){
        UserDTO userDTO = null;
        List<ProductDTO> productDTOList = productService.findAll();
        String txt = "";

        CartDTO cartDTO = CartUtils.getCartByCookieAndDeleteCookie(request.getCookies(), productDTOList,txt,response);

        if(authentication != null){
            userDTO = userService.getCurrentLoggedInCustomer(authentication);
        }
        CartUtils.DeleteCartItemByProductIdAndAuthentication(userDTO,cartDTO,txt,response,productId);
        return "redirect:/cart";
    }

}
