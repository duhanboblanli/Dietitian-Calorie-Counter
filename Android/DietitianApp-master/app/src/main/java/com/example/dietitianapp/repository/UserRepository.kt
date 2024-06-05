package com.example.dietitianapp.repository

import com.example.dietitianapp.data.remote.ApiService
import com.example.dietitianapp.data.remote.CallBack
import com.example.dietitianapp.di.IoDispatcher
import com.example.dietitianapp.model.BaseResponse
import com.example.dietitianapp.model.Login
import com.example.dietitianapp.model.Register
import com.example.dietitianapp.model.TokenResponse
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.channels.awaitClose
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.callbackFlow
import kotlinx.coroutines.flow.flowOn
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class UserRepository @Inject constructor(
    private val apiService: ApiService,
    @IoDispatcher private val ioDispatcher: CoroutineDispatcher
) {

    fun setRegister(register: Register): Flow<BaseResponse<TokenResponse>> = callbackFlow {
        apiService.setRegister(register).enqueue(CallBack(this.channel))
        awaitClose { close() }
    }.flowOn(ioDispatcher)

    fun setLogin(login: Login): Flow<BaseResponse<TokenResponse>> = callbackFlow {
        apiService.setLogin(login).enqueue(CallBack(this.channel))
        awaitClose { close() }
    }.flowOn(ioDispatcher)
}