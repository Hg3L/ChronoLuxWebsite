package com.hau.controller;

import com.hau.dto.UserFaceBookDto;
import com.hau.dto.UserGoogleDto;
import com.hau.util.AuthenticationProviderUtil;
import com.hau.util.UserFaceBookUtil;
import com.hau.util.UserGoogleUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;

@Controller
public class LoginController {
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
            AuthenticationProviderUtil.GrantedPermission(userGoogleDto);
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
            AuthenticationProviderUtil.GrantedPermission(userFaceBookDto);
            System.out.println(userFaceBookDto);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return mav;

    }

}
