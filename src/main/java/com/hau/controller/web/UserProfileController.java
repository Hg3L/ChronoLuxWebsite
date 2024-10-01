package com.hau.controller.web;

import com.hau.constant.SystemConstant;
import com.hau.dto.MyUser;
import com.hau.dto.UserDTO;
import com.hau.service.IUserService;
import com.hau.util.AuthenticationProviderUtil;
import com.hau.util.SecurityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user-profile")
public class UserProfileController {
    @Autowired
    private IUserService userService;
    @GetMapping
    public String  UserProfile(Model model){
        model.addAttribute("user",userService.findOneByUserNameAndStatus(SecurityUtil.getPrincipal().getUsername(), SystemConstant.ACTIVE_STATUS));
        return "web/profile";
    }
    @PostMapping
    public String saveAndUpdate(@ModelAttribute UserDTO userDTO){
        String view = "redirect:/user-profile";
        userService.save(userDTO);
        AuthenticationProviderUtil.GrantedPermission(userDTO);
        //
        return view;
    }
}
