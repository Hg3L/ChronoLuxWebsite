package com.hau.controller.web;

import com.hau.dto.UserDTO;
import com.hau.service.FileService;
import com.hau.service.UserService;
import com.hau.util.AuthenticationProviderUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.bind.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Controller
@RequestMapping("/user-profile")
public class UserProfileController {
    @Autowired
    private UserService userService;
    @Autowired
    private FileService fileService;
    private static final String UPLOAD_DIR = "user-logos";
    private static final String DEFAULT_USER_AVATAR_DIR = "account-representation";
    @GetMapping
    public String  UserProfile(Model model, @AuthenticationPrincipal Authentication authentication){
       model.addAttribute("user",userService.getCurrentLoggedInCustomer(authentication));
       return "web/profile";
    }

    @PostMapping
    public String saveAndUpdate(@ModelAttribute UserDTO userDTO, @RequestParam("img") MultipartFile multipartFile) throws IOException {
        String view = "";
        if (multipartFile.isEmpty()) {
            multipartFile = fileService.handleDefaultFile(userDTO.getImgUrl(), UPLOAD_DIR);
            String avatar = fileService.saveFile(multipartFile, UPLOAD_DIR);
            userDTO.setImgUrl(avatar);
        }
        else{
            String avatar = fileService.saveFile(multipartFile, UPLOAD_DIR);
            userDTO.setImgUrl(avatar);
        }
        UserDTO user =  userService.save(userDTO, "user");
        AuthenticationProviderUtil.GrantedPermission(userDTO);
        if(user!= null){
            view = "redirect:/user-profile?success";
        }
        else{
            view = "redirect:/user-profile?error";
        }

        //
        return view;
    }
}
