package com.tez.dieticianpatientapp.dto;

import com.tez.dieticianpatientapp.entities.User;
import com.tez.dieticianpatientapp.utils.UserType;
import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@AllArgsConstructor
public class UserDto {
    String tckn;
    UserType userType;

    public UserDto(User user){

        tckn = user.getTckn();
        userType = user.getUserType();
    }
}
