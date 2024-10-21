package com.hau.controller;

import com.hau.dto.UserDTO;
import com.hau.exception.CustomerNotFoundException;
import com.hau.service.UserService;
import com.hau.util.GetSiteURLUtil;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;

@Controller
public class ForgotPasswordController {
    @Autowired
    private UserService userService;

    @Autowired
    private JavaMailSender mailSender;
    @RequestMapping(value = "/login/forgot-password",method = RequestMethod.GET)
    public ModelAndView registerPage(){
        ModelAndView mav = new ModelAndView("login/forgot-password");
        return mav;
    }
    @RequestMapping(value = "/login/forgot-password",method = RequestMethod.POST)
    public ModelAndView processForgotPasswordForm(HttpServletRequest request, Model model){
        ModelAndView mav = new ModelAndView("login/forgot-password");
        String email = request.getParameter("email");
        String token = RandomStringUtils.randomAlphanumeric(45);
        try {
            userService.updateResetPasswordToken(token,email);
            String resetPasswordLink = GetSiteURLUtil.getSiteURL(request)+ "/login/reset_password?token="+token;
            sendEmail(email,resetPasswordLink);
            model.addAttribute("message","We have sent a reset password link to your email. Please Check");
        } catch (CustomerNotFoundException ex) {
            model.addAttribute("error", ex.getMessage());
        }
        catch (UnsupportedEncodingException | MessagingException e) {
            model.addAttribute("error", "Error while sending email");
        }

        return mav;
    }

    @GetMapping("/login/reset_password")
    public ModelAndView showResetPasswordForm(@RequestParam(value = "token") String token, Model model) {
        String view = "login/reset-password";
        UserDTO user =  userService.findOneByResetPasswordToken(token);
        model.addAttribute("token", token);
        if (user == null) {
            model.addAttribute("message", "Invalid Token");
            view = "redirect:/login/forgot-password";
        }
        return new ModelAndView(view);
    }
    @PostMapping("/login/reset_password")
    public String processResetPassword(@RequestParam(value = "token") String token, @RequestParam(value = "password") String password,Model model){
        UserDTO user = userService.findOneByResetPasswordToken(token);
        if (user == null) {
            model.addAttribute("message", "Invalid Token");
        }
        else{
            userService.updatePassword(user,password);
            model.addAttribute("message","You have successfully changed your password");
        }
        return "/login/reset-password";
    }


    public void sendEmail(String email , String resetPasswordLink) throws MessagingException, UnsupportedEncodingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message);
        helper.setFrom("contact@chronolux.com","ChronoLux support");
        helper.setTo(email);
        helper.setSubject("Here's the link to reset your password");
        String content = "<p>Hello,</p>"
                + "<p>You have requested to reset your password.</p>"
                + "<p>Click the link below to change your password:</p>"
                + "<p><a href=\"" + resetPasswordLink + "\">Change my password</a></p>"
                + "<br>"
                + "<p>Ignore this email if you do remember your password, "
                + "or you have not made the request.</p>";
        helper.setText(content,true);
        mailSender.send(message);
    }
}
