package com.hau.controller;

import com.hau.constant.SystemConstant;
import com.hau.dto.UserDTO;
import com.hau.dto.UserFaceBookDto;
import com.hau.dto.UserGoogleDto;
import com.hau.service.UserService;
import com.hau.util.AuthenticationProviderUtil;
import com.hau.util.UserFaceBookUtil;
import com.hau.util.UserGoogleUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Controller
public class LoginController {
    @Autowired
    private UserService userService;
    @RequestMapping(value = "/login" ,method = RequestMethod.GET)
    public ModelAndView Login(){
        ModelAndView mav = new ModelAndView("login/sign-in");
        return  mav;
    }
    @RequestMapping(value = "/accessDenied", method = RequestMethod.GET)
    public ModelAndView accessDenied() {
        ModelAndView mav = new ModelAndView("redirect:/login?accessDenied");
        return mav;
    }
    @RequestMapping(value = "/login-google", method = RequestMethod.GET)
    public ModelAndView LoginGoogle(@RequestParam String code) {
        ModelAndView mav = new ModelAndView("redirect:/home");
        try {
            String token = UserGoogleUtil.getToken(code);
            UserGoogleDto userGoogleDto = UserGoogleUtil.toUser(token).getUserGoogleDto();
            AuthenticationProviderUtil.GrantedPermissionO2Auth(userGoogleDto);
            if(userService.findOneByEmailAndRoleCode(userGoogleDto.getEmail(),"ROLE_USER_GOOGLE") == null){
                UserDTO userDTO = new UserDTO();
                userDTO.setEmail(userGoogleDto.getEmail());
                userDTO.setFullName(userGoogleDto.getFamily_name() +" "+ userGoogleDto.getGiven_name());
                userDTO.setPassword(null);
                List<String> rolescode = new ArrayList<>();
                rolescode.add("ROLE_USER_GOOGLE");
                userDTO.setRoleCode(rolescode);
                userDTO.setStatus(SystemConstant.ACTIVE_STATUS);
                userDTO.setUserName(" ");
                userDTO.setImgUrl(userGoogleDto.getPicture());
                userService.save(userDTO);
            }

        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return mav;

    }
    @RequestMapping(value = "/login-facebook", method = RequestMethod.GET)
    public ModelAndView LoginFacebook(@RequestParam String code) {
        ModelAndView mav = new ModelAndView("redirect:/home");
        try {
            String token = UserFaceBookUtil.getToken(code);
            UserFaceBookDto userFaceBookDto = UserFaceBookUtil.toUser(token).getUserFaceBookDto();
            AuthenticationProviderUtil.GrantedPermissionO2Auth(userFaceBookDto);
            if(userService.findOneByEmailAndRoleCode(userFaceBookDto.getEmail(),"ROLE_USER_FACEBOOK") == null){
                UserDTO userDTO = new UserDTO();
                userDTO.setEmail(userFaceBookDto.getEmail());
                userDTO.setFullName(userFaceBookDto.getName());
                userDTO.setPassword(null);
                List<String> rolescode = new ArrayList<>();
                rolescode.add("ROLE_USER_FACEBOOK");
                userDTO.setRoleCode(rolescode);
                userDTO.setStatus(SystemConstant.ACTIVE_STATUS);
                userDTO.setUserName(" ");
                userDTO.setImgUrl(userFaceBookDto.getImgUrl());
                userService.save(userDTO);
            }

        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return mav;

    }

}
