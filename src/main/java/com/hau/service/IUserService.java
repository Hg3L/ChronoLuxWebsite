package com.hau.service;

import com.hau.dto.UserDTO;


public interface IUserService {
    public UserDTO findOneByUserNameAndStatus(String userName, int status);
    public UserDTO save(UserDTO userDTO);
}
