package com.example.dietitianapp.model

sealed class BaseResponse<T> {

    data class Success<T>(val data: T): BaseResponse<T>()
    data class Error<T>(val error:ErrorResponse): BaseResponse<T>()


}
