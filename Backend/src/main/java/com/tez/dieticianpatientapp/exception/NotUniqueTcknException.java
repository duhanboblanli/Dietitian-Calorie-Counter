package com.tez.dieticianpatientapp.exception;

import org.springframework.context.i18n.LocaleContextHolder;

public class NotUniqueTcknException extends RuntimeException{
    public NotUniqueTcknException() {
        super("Bu tckn zaten kullanımda");
    }
}
