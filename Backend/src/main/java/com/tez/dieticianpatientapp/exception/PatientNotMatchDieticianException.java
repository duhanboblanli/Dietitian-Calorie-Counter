package com.tez.dieticianpatientapp.exception;

public class PatientNotMatchDieticianException extends RuntimeException{
    public PatientNotMatchDieticianException() {
        super("Hasta ile Diyetisyen eşleşmiyor");
    }
}
