package com.tez.dieticianpatientapp.exception;

public class DietNotFoundException extends RuntimeException{

    public DietNotFoundException() {
    }

    public DietNotFoundException(String message) {
        super(message);
    }
}
