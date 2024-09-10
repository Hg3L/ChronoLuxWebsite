package com.hau.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ShopController {
    @RequestMapping(value = "/shop", method = RequestMethod.GET)
        public ModelAndView shopPage(){
        ModelAndView mav = new ModelAndView("web/shop");
        return mav;
        }
}
