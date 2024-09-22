package com.hau.util;

import com.hau.dto.MyUser;
import com.hau.dto.UserGoogleDto;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.ArrayList;
import java.util.List;

public class AuthenticationProviderUtil {
    public static void  GrantedPermission(UserGoogleDto userGoogleDto){
        List<GrantedAuthority> authorities = new ArrayList<>();
        authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
        MyUser user = new MyUser(userGoogleDto.getGiven_name(), "", true, true, true, true, authorities);
        user.setFullName(userGoogleDto.getGiven_name());
        Authentication auth = new UsernamePasswordAuthenticationToken(user, null, user.getAuthorities());
        SecurityContextHolder.getContext().setAuthentication(auth);
    }
}
