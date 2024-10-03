package com.hau.controller;

import com.hau.dto.UserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.hau.service.IUserService;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;

@Controller
@RequestMapping("/login")
public class RegisterController {
    @Autowired
    private IUserService userService;

    @PostMapping("/add")
    public String addNewUser(@ModelAttribute("user") UserDTO user, HttpServletRequest request){
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
        userService.save(user);
        return "redirect:/login?registerSuccessful";
    }

    @GetMapping("/register")
    public String showRegisterPage(){
        return "login/register";
    }
}
