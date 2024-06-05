package com.example.dietitianapp.usecase.user

import com.example.dietitianapp.model.BaseResponse
import com.example.dietitianapp.model.Login
import com.example.dietitianapp.model.TokenResponse
import com.example.dietitianapp.repository.UserRepository
import com.example.dietitianapp.domain.SingleParaMeterUseCase
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject

class LoginUseCase @Inject constructor(
    private val userRepository: UserRepository
) : SingleParaMeterUseCase<Login, Flow<BaseResponse<TokenResponse>>> {

    override fun execute(param: Login): Flow<BaseResponse<TokenResponse>> = userRepository.setLogin(param)

}