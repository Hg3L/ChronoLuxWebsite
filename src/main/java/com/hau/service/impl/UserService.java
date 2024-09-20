package com.hau.service.impl;

import com.hau.converter.UserConverter;
import com.hau.dto.UserDTO;
import com.hau.entity.RoleEntity;
import com.hau.entity.UserEntity;
import com.hau.exception.CustomerNotFoundException;
import com.hau.repository.RoleRepository;
import com.hau.repository.UserRepository;
import com.hau.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserService implements IUserService {
    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private UserConverter userConverter;
    @Autowired
    private UserRepository userRepository;
    @Override
    public UserDTO findOneByUserNameAndStatus(String userName, int status) {
        return null;
    }

    @Override
    @Transactional
    public UserDTO save(UserDTO userDTO) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String rawPassword = userDTO.getPassword();  // Mật khẩu cần mã hóa
        String encodedPassword = encoder.encode(rawPassword); // mã hóa mk
        userDTO.setPassword(encodedPassword);
        if(userDTO.getRoleCode().isEmpty() && userDTO.getStatus() == 0){ // đăng ký tài khoản mặc định role là USER
            List<String>  rolescode = new ArrayList<>();
            rolescode.add("ROLE_USER");
            userDTO.setRoleCode(rolescode);
            userDTO.setStatus(1);
        }
        List<RoleEntity> roleEntities = new ArrayList<>();
        for(String roleCode : userDTO.getRoleCode()){
            RoleEntity roleEntity = roleRepository.findOneByCode(roleCode);
            roleEntities.add(roleEntity);
        }
      
        UserEntity userEntity = userConverter.toEntity(userDTO);
        userEntity.setRoles(roleEntities);
        return userConverter.toDTO(userRepository.save(userEntity));
    }

    @Override
    public void updateResetPasswordToken(String token, String email) throws CustomerNotFoundException {
        UserEntity user = userRepository.findOneByEmail(email);
        if(user != null){
            user.setResetPasswordToken(token);
            userRepository.save(user);
        }
        else{
            throw new CustomerNotFoundException("Could not find any customer with email "+email);
        }
    }

    @Override
    public UserDTO findOneByResetPasswordToken(String resetPasswordToken) {
        return userConverter.toDTO(userRepository.findOneByResetPasswordToken(resetPasswordToken));

    }

    @Override
    public void updatePassword(UserEntity user, String newPassword) {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String encodedPassword = passwordEncoder.encode(newPassword);
        user.setPassword(encodedPassword);
        user.setResetPasswordToken(null);
        userRepository.save(user);
    }
}
