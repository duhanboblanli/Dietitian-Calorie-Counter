package com.tez.dieticianpatientapp.validation;

import com.tez.dieticianpatientapp.entities.User;
import com.tez.dieticianpatientapp.repository.UserRepository;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import org.springframework.beans.factory.annotation.Autowired;

public class UniqueTcknValidator implements  ConstraintValidator<UniqueTckn, String> {

    @Autowired
    UserRepository userRepository;

    @Override
    public void initialize(UniqueTckn constraintAnnotation) {
        ConstraintValidator.super.initialize(constraintAnnotation);
    }

    @Override
    public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {
        return userRepository.findByTckn(s).isEmpty();
    }
}
