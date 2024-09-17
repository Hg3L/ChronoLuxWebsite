package com.hau.api;

import com.hau.dto.UserDTO;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/user")
public class UserAPI {
    @PostMapping
    public UserDTO createUser(@RequestBody UserDTO newUser){
        return newUser;
    }

}
