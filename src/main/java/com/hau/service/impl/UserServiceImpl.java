package com.hau.service.impl;

import com.hau.constant.SystemConstant;
import com.hau.converter.UserConverter;
import com.hau.dto.CustomerO2Auth;
import com.hau.dto.MyUser;
import com.hau.dto.UserDTO;
import com.hau.entity.RoleEntity;
import com.hau.entity.UserEntity;
import com.hau.exception.CustomerNotFoundException;
import com.hau.repository.RoleRepository;
import com.hau.repository.UserRepository;
import com.hau.service.UserService;
import com.hau.util.EncodePasswordUtil;
import com.hau.util.SecurityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private UserConverter userConverter;
    @Autowired
    private UserRepository userRepository;
    @Override
    public UserDTO findOneByUserNameAndStatus(String userName, int status) {
        UserEntity userEntity = userRepository.findOneByUserNameAndStatus(userName,status);
        UserDTO user = null;
        if(userEntity != null){
            user = userConverter.toDTO(userEntity);
        }
        return user;
    }

    @Override
    public UserDTO findOneById(Long id) {
        UserEntity userEntity = userRepository.findOne(id);
        UserDTO user = userConverter.toDTO(userEntity);
        return user;
    }


    @Override
    @Transactional
    public UserDTO save(UserDTO userDTO, String typeAccount) {
        UserEntity userEntity = new UserEntity();
        if(typeAccount.equals("admin")){
            List<String>  rolescode = new ArrayList<>();
            rolescode.add("ROLE_ADMIN");
            userDTO.setRoleCode(rolescode);
            userDTO.setStatus(1);
        }
        else if(typeAccount.equals("user")){
            List<String>  rolescode = new ArrayList<>();
            rolescode.add("ROLE_USER");
            userDTO.setRoleCode(rolescode);
            userDTO.setStatus(1);
        }
        else if(typeAccount.equals("user_facebook")){
            List<String>  rolescode = new ArrayList<>();
            rolescode.add("ROLE_USER_FACEBOOK");
            userDTO.setRoleCode(rolescode);
            userDTO.setStatus(1);
        }
        else if(typeAccount.equals("user_google")){
            List<String>  rolescode = new ArrayList<>();
            rolescode.add("ROLE_USER_GOOGLE");
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

    @Transactional
    @Override
    public void update(UserDTO userDTO) {
        UserEntity user = userRepository.findOne(userDTO.getId());
        user.setFullName(userDTO.getFullName());
        user.setStatus(userDTO.getStatus());
        if(userDTO.getEmail() != null){
            user.setEmail(userDTO.getEmail());
        }
        user.setImgUrl(userDTO.getImgUrl());
        userRepository.save(user);
    }

    @Override
    public void updateResetPasswordToken(String token, String email) throws CustomerNotFoundException {
        UserEntity user = userRepository.findOneByEmailAndPasswordNotNull(email);
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

    @Override
    public UserDTO getCurrentLoggedInCustomer(Authentication authentication) {
        if(authentication == null){
            return  null;
        }
        UserDTO userDTO = null;
        Object principal = authentication.getPrincipal();
        if(principal instanceof MyUser){
            userDTO = userConverter.toDTO(userRepository.
                    findOneByUserNameAndStatus(SecurityUtil.getPrincipal().getUsername(), SystemConstant.ACTIVE_STATUS));
        } else if(principal instanceof CustomerO2Auth){
            String email = ((CustomerO2Auth) principal).getEmail();
            userDTO = userConverter.toDTO(userRepository.findByEmailAndRoleCode(email,((CustomerO2Auth) principal).getRoleCode()));
        }
        return userDTO;
    }

    @Override
    public UserDTO findOneByEmailAndPassWordNotNull(String email) {
        return userConverter.toDTO(userRepository.findOneByEmailAndPasswordNotNull(email));
    }

    @Override
    public UserDTO findOneByEmailAndRoleCode(String email, String roleCode) {
        return userConverter.toDTO(userRepository.findByEmailAndRoleCode(email,roleCode));
    }

    @Override
    public Page<UserDTO> findAllAdminAccounts(int page, int limit) {
        Pageable pageable = new PageRequest(page-1, limit);
        Page<UserEntity> userEntities = userRepository.findAllAdminAccounts(pageable);
        return userEntities.map(userEntity -> userConverter.toDTO(userEntity));
    }

    @Override
    public Page<UserDTO> findAllUserAccounts(int page, int limit) {
        Pageable pageable = new PageRequest(page-1, limit);
        Page<UserEntity> userEntities = userRepository.findAllUserAccounts(pageable);
        return userEntities.map(userEntity -> userConverter.toDTO(userEntity));
    }

    @Override
    public boolean usernameExists(String username) {
        UserEntity userEntity = userRepository.findOneByUserName(username);
        return userEntity != null;
    }
}
