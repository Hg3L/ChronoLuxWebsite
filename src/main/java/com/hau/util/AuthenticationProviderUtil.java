package com.hau.util;

import com.hau.dto.MyUser;
import com.hau.dto.UserFaceBookDto;
import com.hau.dto.UserGoogleDto;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.ArrayList;
import java.util.List;

public class AuthenticationProviderUtil {
    public static void  GrantedPermission(Object account){
        List<GrantedAuthority> authorities = new ArrayList<>();
        authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
        if (account instanceof UserGoogleDto) {
            UserGoogleDto userGoogleDto = (UserGoogleDto) account;
            MyUser user = new MyUser(userGoogleDto.getGiven_name(), "", true, true, true, true, authorities);
            user.setFullName(userGoogleDto.getGiven_name());
            Authentication auth = new UsernamePasswordAuthenticationToken(user, null, user.getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(auth);
        } else if (account instanceof UserFaceBookDto) {
            // Xử lý nếu object là kiểu AnotherClass
            UserFaceBookDto userFaceBookDto = (UserFaceBookDto) account;
            MyUser user = new MyUser(userFaceBookDto.getName(), "", true, true, true, true, authorities);
            user.setFullName(userFaceBookDto.getName());
            Authentication auth = new UsernamePasswordAuthenticationToken(user, null, user.getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(auth);
        } else {
            throw new IllegalArgumentException("Unsupported object type");
        }
    }
}