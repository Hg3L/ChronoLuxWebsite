package com.hau.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller(value = "ControllerOfAdmin")
public class HomeController {
    @RequestMapping("/admin/home")
    public String showDashboard() {
        return "admin/home";
    }
}
