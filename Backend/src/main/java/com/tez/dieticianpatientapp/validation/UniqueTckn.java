package com.tez.dieticianpatientapp.validation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import jakarta.validation.Constraint;
import jakarta.validation.Payload;


@Constraint(validatedBy = UniqueTcknValidator.class)
@Target({ ElementType.FIELD })
@Retention(RetentionPolicy.RUNTIME)
public @interface UniqueTckn {
    String message() default "Bu tc kimlik numarası ile bir kullanıcı zaten bulunmakta";

    Class<?>[] groups() default { };

    Class<? extends Payload>[] payload() default { };
}
