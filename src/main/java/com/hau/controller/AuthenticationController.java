package com.hau.controller;

import com.hau.constant.SystemConstant;
import com.hau.dto.CustomerO2Auth;
import com.hau.dto.MyUser;
import com.hau.dto.UserDTO;
import com.hau.service.UserService;
import com.hau.util.SecurityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@Controller
public class AuthenticationController {

    @Autowired
    private UserService userService;

    @GetMapping("/check")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> checkAuthentication(Authentication authentication) {
        Map<String, Object> response = new HashMap<>();
        if (authentication == null || !authentication.isAuthenticated()) {
            response.put("authenticated", false);
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
        }
        response.put("authenticated", true);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/userId")
    public ResponseEntity<Long> getCurrentUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDTO userDTO = userService.getCurrentLoggedInCustomer(authentication);
        return ResponseEntity.ok(userDTO.getId());
    }

}
