package com.hau.converter;

import com.hau.dto.UserDTO;
import com.hau.entity.RoleEntity;
import com.hau.entity.UserEntity;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class UserConverter {
    public UserDTO toDTO(UserEntity userEntity){
        UserDTO userDTO = new UserDTO();
        userDTO.setId(userEntity.getId());
        userDTO.setUserName(userEntity.getUserName());
        userDTO.setPassword(userEntity.getPassword());
        userDTO.setStatus(userEntity.getStatus());
        List<String> rolesCode = new ArrayList<>();
        for(RoleEntity role : userEntity.getRoles()){
            rolesCode.add(role.getCode());
        }
        userDTO.setRoleCode(rolesCode);
        return userDTO;
    }
    public UserEntity toEntity(UserDTO userDTO){
        UserEntity userEntity = new UserEntity();
        userEntity.setUserName(userDTO.getUserName());
        userEntity.setEmail(userDTO.getEmail());
        userEntity.setFullName(userDTO.getFullName());
        userEntity.setPassword(userDTO.getPassword());
        userEntity.setStatus(userDTO.getStatus());
        return userEntity;
    }
}