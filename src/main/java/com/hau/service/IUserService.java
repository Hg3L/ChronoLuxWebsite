package com.hau.service;

import com.hau.dto.UserDTO;
import com.hau.entity.UserEntity;
import com.hau.exception.CustomerNotFoundException;
import org.springframework.security.core.Authentication;


public interface IUserService {
    public UserDTO findOneByUserNameAndStatus(String userName, int status);
    public UserDTO save(UserDTO userDTO);
    public void updateResetPasswordToken(String token,String email) throws CustomerNotFoundException;
    public UserDTO findOneByResetPasswordToken(String resetPasswordToken);
    public void updatePassword(UserDTO user, String password );
    public UserDTO getCurrentLoggedInCustomer(Authentication authentication);
    public UserDTO findOneByEmailAndPassWordEmpty(String email);
    public UserDTO findOneByEmailAndRoleCode(String email , String roleCode);
}
