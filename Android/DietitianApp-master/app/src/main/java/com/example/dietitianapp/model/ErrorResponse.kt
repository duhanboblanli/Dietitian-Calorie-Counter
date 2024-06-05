package com.example.dietitianapp.model

data class ErrorResponse(
    var status: Int = 400,
    var message: String? = null,
    var path: String? = null,
    var timestamp: Long = 0,
    var validationErrors: Map<String, String>? = null
)