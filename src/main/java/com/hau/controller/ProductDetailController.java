package com.hau.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ProductDetailController {
    @RequestMapping(value = "/product-detail", method = RequestMethod.GET)
    public ModelAndView productDetailPage() {
        ModelAndView mav = new ModelAndView("web/product-detail");
        return mav;
    }
}
