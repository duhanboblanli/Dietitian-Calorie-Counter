package com.example.dietitianapp.usecase.user

import com.example.dietitianapp.model.BaseResponse
import com.example.dietitianapp.model.Register
import com.example.dietitianapp.model.TokenResponse
import com.example.dietitianapp.repository.UserRepository
import com.example.dietitianapp.domain.SingleParaMeterUseCase
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject

class RegisterUseCase @Inject constructor(
    private val userRepository: UserRepository
) : SingleParaMeterUseCase<Register, Flow<BaseResponse<TokenResponse>>> {

    override fun execute(param: Register): Flow<BaseResponse<TokenResponse>> = userRepository.setRegister(param)

}