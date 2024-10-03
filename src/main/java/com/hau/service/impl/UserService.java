package com.hau.service.impl;

import com.hau.converter.UserConverter;
import com.hau.dto.UserDTO;
import com.hau.entity.RoleEntity;
import com.hau.entity.UserEntity;
import com.hau.exception.CustomerNotFoundException;
import com.hau.repository.RoleRepository;
import com.hau.repository.UserRepository;
import com.hau.service.IUserService;
import com.hau.util.EncodePasswordUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
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
        UserEntity userEntity = userRepository.findOneByUserNameAndStatus(userName,status);
        UserDTO user = userConverter.toDTO(userEntity);
        return user;
    }
    public UserDTO findOneById(Long id) {
        UserEntity userEntity = userRepository.findOne(id);
        UserDTO user = userConverter.toDTO(userEntity);
        return user;
    }


    @Override
    @Transactional
    public UserDTO save(UserDTO userDTO) {
        UserEntity userEntity = new UserEntity();
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
        // Kiểm tra nếu mật khẩu chưa được mã hóa (bằng cách kiểm tra tiền tố của chuỗi BCrypt)
        if (userDTO.getPassword() != null && !userDTO.getPassword().startsWith("$2a$") && !userDTO.getPassword().startsWith("$2b$") && !userDTO.getPassword().startsWith("$2y$")) {
              // Mã hóa mật khẩu
            userDTO.setPassword(EncodePasswordUtil.encode(userDTO.getPassword()));
        }
        // update
        if(userDTO.getId() != null){
            if(userDTO.getSurName() != null || userDTO.getFirstName()!= null){
                String fullName = userDTO.getSurName() +" "+ userDTO.getFirstName();
                userDTO.setFullName(fullName);
            }
            UserEntity oldUser = userRepository.findOne(userDTO.getId());
            oldUser.setRoles(roleEntities);
            userEntity = userConverter.toEntity(oldUser,userDTO);
        }
        // save
        else{
            userEntity =  userConverter.toEntity(userDTO);
            userEntity.setRoles(roleEntities);
        }

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
    public void updatePassword(UserDTO user, String newPassword) {
        UserEntity updateUser = userRepository.findOne(user.getId());
        updateUser.setPassword( EncodePasswordUtil.encode(newPassword));
        updateUser.setResetPasswordToken(null);
        List<RoleEntity> roleEntities = new ArrayList<>();
        for(String roleCode : user.getRoleCode()){
            RoleEntity roleEntity = roleRepository.findOneByCode(roleCode);
            roleEntities.add(roleEntity);
        }
        updateUser.setRoles(roleEntities);
        userRepository.save(updateUser);
    }
}
