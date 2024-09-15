package com.hau.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LoginController {
    @RequestMapping(value = "/login" ,method = RequestMethod.GET)
    public ModelAndView Login(){
        ModelAndView mav = new ModelAndView("login");
        return  mav;
    }
    @RequestMapping(value = "/accessDenied", method = RequestMethod.GET)
    public ModelAndView accessDenied() {
        ModelAndView mav = new ModelAndView("redirect:/login?accessDenied");
        return mav;
    }

}
