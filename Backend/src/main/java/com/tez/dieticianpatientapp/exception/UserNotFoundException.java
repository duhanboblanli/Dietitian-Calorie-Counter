package com.tez.dieticianpatientapp.exception;

public class UserNotFoundException extends RuntimeException{
    public UserNotFoundException() {
        super("Kullanıcı Bulunamadı");
    }
}
