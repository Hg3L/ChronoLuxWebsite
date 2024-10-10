package com.hau.controller.web;

import com.hau.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ShopController {
    @Autowired
    private IProductService productService;
    @RequestMapping(value = "/shop", method = RequestMethod.GET)
        public ModelAndView shopPage(){
        ModelAndView mav = new ModelAndView("web/shop");
        mav.addObject("products",productService.findAll());
        return mav;
        }
}
