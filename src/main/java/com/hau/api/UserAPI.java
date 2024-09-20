package com.hau.api;

import com.hau.dto.UserDTO;
import com.hau.service.IUserService;
import com.hau.service.impl.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/user")
public class UserAPI {
    @Autowired
    private IUserService userService;
    @PostMapping
    public UserDTO createUser(@RequestBody UserDTO newUser){
        return userService.save(newUser);
    }

}
