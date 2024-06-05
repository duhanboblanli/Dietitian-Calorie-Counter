package com.tez.dieticianpatientapp.error;

import com.tez.dieticianpatientapp.entities.User;
import com.tez.dieticianpatientapp.exception.NotUniqueTcknException;
import com.tez.dieticianpatientapp.exception.PatientNotMatchDieticianException;
import com.tez.dieticianpatientapp.exception.UserNotFoundException;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.AuthenticationException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

@RestControllerAdvice
public class ErrorHandler {
    @ExceptionHandler({NotUniqueTcknException.class, MethodArgumentNotValidException.class, AuthenticationException.class, UserNotFoundException.class, PatientNotMatchDieticianException.class})
    ResponseEntity<ApiError> handleException(Exception exception, HttpServletRequest request){
        HttpStatus status = HttpStatus.BAD_REQUEST;
        ApiError apiError = new ApiError();
        apiError.setPath(request.getRequestURI());
        apiError.setMessage(exception.getMessage());
        if(exception instanceof MethodArgumentNotValidException){
            var validationErrors = ((MethodArgumentNotValidException)exception).getBindingResult().getFieldErrors().stream().collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage, (existing, replacing) -> existing));
            Map.Entry<String, String> firstEntry = validationErrors.entrySet().iterator().next();
            apiError.setMessage(firstEntry.getValue());
            apiError.setValidationErrors(validationErrors);
        }
        else if(exception instanceof AuthenticationException){
            apiError.setMessage("Şifre veya kullanıcı adı hatalı");
            status = HttpStatus.UNAUTHORIZED;
        }
        apiError.setStatus(status.value());
        return ResponseEntity.status(status).body(apiError);
    }
}
