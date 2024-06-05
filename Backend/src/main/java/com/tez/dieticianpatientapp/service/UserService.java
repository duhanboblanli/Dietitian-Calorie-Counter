package com.tez.dieticianpatientapp.service;


import com.tez.dieticianpatientapp.dto.UserDto;
import com.tez.dieticianpatientapp.entities.User;
import com.tez.dieticianpatientapp.exception.NotUniqueTcknException;
import com.tez.dieticianpatientapp.repository.UserRepository;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    public ResponseEntity<UserDto> saveUser(User user){
        try {
            userRepository.save(user);
        }
        catch (DataIntegrityViolationException ex){
            throw new NotUniqueTcknException();
        }
        return ResponseEntity.status(HttpStatus.CREATED).body(new UserDto(user));
    }

    public Optional<User> getUserByTckn(String tckn) {
        return userRepository.findByTckn(tckn);
    }

}
