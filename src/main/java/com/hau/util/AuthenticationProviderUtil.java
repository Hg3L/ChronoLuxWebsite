package com.hau.util;

import com.hau.dto.MyUser;
import com.hau.dto.UserDTO;
import com.hau.dto.UserFaceBookDto;
import com.hau.dto.UserGoogleDto;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.util.ArrayList;
import java.util.List;

public class AuthenticationProviderUtil {
    public static void  GrantedPermissionO2Auth(Object account){
        List<GrantedAuthority> authorities = new ArrayList<>();
        authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
        if (account instanceof UserGoogleDto) {
            UserGoogleDto userGoogleDto = (UserGoogleDto) account;
            MyUser user = new MyUser(userGoogleDto.getGiven_name(), "", true, true, true, true, authorities);
            user.setFullName(userGoogleDto.getGiven_name());
            user.setFirstName(userGoogleDto.getGiven_name());
            user.setSurName(userGoogleDto.getFamily_name());
            user.setImgUrl(userGoogleDto.getPicture());
            user.setEmail(userGoogleDto.getEmail());
            Authentication auth = new UsernamePasswordAuthenticationToken(user, null, user.getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(auth);
        } else if (account instanceof UserFaceBookDto) {
            // Xử lý nếu object là kiểu AnotherClass
            UserFaceBookDto userFaceBookDto = (UserFaceBookDto) account;
            MyUser user = new MyUser(userFaceBookDto.getName(), "", true, true, true, true, authorities);
            user.setFullName(userFaceBookDto.getName());
            //
            String[] parts = userFaceBookDto.getName().split(" ");
            String firstName = parts[parts.length -1];
            user.setFirstName(firstName);
            //
            int lastSpaceIndex = userFaceBookDto.getName().lastIndexOf(" ");
            String surName = userFaceBookDto.getName().substring(0,lastSpaceIndex);
            user.setSurName(surName);
            //
            user.setImgUrl(userFaceBookDto.getImgUrl());
            user.setEmail(userFaceBookDto.getEmail());
            Authentication auth = new UsernamePasswordAuthenticationToken(user, null, user.getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(auth);
        } else {
            throw new IllegalArgumentException("Unsupported object type");
        }
    }
    public static void  GrantedPermission(UserDTO userDTO) {
        String encodedPassword = EncodePasswordUtil.encode(userDTO.getPassword());
        MyUser user = new MyUser(userDTO.getUserName(), encodedPassword, true, true, true, true, SecurityUtil.getPrincipal().getAuthorities());
        user.setFullName(userDTO.getFullName());
        Authentication auth = new UsernamePasswordAuthenticationToken(user, null, user.getAuthorities());
        SecurityContextHolder.getContext().setAuthentication(auth);
    }
}
