package com.tez.dieticianpatientapp.dto.Request;

import com.tez.dieticianpatientapp.entities.User;
import com.tez.dieticianpatientapp.utils.UserType;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public record UserCreate(

        @Pattern(regexp = "\\d{11}", message = "Tc kimlik numarası 11 haneli olmalı")
        String tckn,

        @Size(min = 8, max=255)
        @Pattern(regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).*$", message = "Şifreniz bir büyük bir küçük harf ve rakam içermeli")
        String password,

        UserType userType
) {
    public User toUser(){
        User user = new User();
        user.setUserType(userType);
        user.setPassword(password);
        user.setTckn(tckn);
        return user;
    }
}
