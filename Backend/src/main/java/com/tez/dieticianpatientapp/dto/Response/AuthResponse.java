package com.tez.dieticianpatientapp.dto.Response;

public record AuthResponse(String message,
                           String accessToken,
                           long id) {

}
