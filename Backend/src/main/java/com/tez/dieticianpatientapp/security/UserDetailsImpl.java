package com.tez.dieticianpatientapp.security;

import com.tez.dieticianpatientapp.entities.User;
import lombok.Getter;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;


public class UserDetailsImpl implements UserDetails {

    String tckn;
    private String password;
    private Collection<? extends GrantedAuthority> authorities;
    private static String userRole = "ROLE_USER";


    private UserDetailsImpl(String username, String password, Collection<? extends GrantedAuthority> authorities) {
        this.tckn = username;
        this.password = password;
        this.authorities = authorities;
    }

    public static UserDetailsImpl create(User user) {
        List<GrantedAuthority> authoritiesList = new ArrayList<>();
        authoritiesList.add(new SimpleGrantedAuthority(userRole));
        return new UserDetailsImpl(user.getTckn(), user.getPassword(), authoritiesList);
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return AuthorityUtils.createAuthorityList(userRole);
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return tckn;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
