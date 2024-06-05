package com.tez.dieticianpatientapp.service;

import com.tez.dieticianpatientapp.entities.User;
import com.tez.dieticianpatientapp.repository.UserRepository;
import com.tez.dieticianpatientapp.security.UserDetailsImpl;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class UserDetailService implements UserDetailsService {

    private final UserRepository userRepository;

    public UserDetailService(UserRepository userRepository){
        this.userRepository = userRepository;
    }
    @Override
    public UserDetails loadUserByUsername(String tckn) throws UsernameNotFoundException {
        User user = userRepository.findByTckn(tckn).orElseThrow(() ->new UsernameNotFoundException("Kullanıcı Bulunamadı"));
        return UserDetailsImpl.create(user);
    }

}
