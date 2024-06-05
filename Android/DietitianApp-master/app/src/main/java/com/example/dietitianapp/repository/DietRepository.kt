package com.example.dietitianapp.repository

import com.example.dietitianapp.data.local.DataStoreManager
import com.example.dietitianapp.data.remote.ApiService
import com.example.dietitianapp.data.remote.CallBack
import com.example.dietitianapp.di.IoDispatcher
import com.example.dietitianapp.model.BaseResponse
import com.example.dietitianapp.model.DietRequest
import com.example.dietitianapp.model.DietResponse
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
class DietRepository@Inject constructor(
    private val apiService: ApiService,
    @IoDispatcher private val ioDispatcher: CoroutineDispatcher,
    var dataStoreManager: DataStoreManager
) {
    fun getDiet(patientId: String): Flow<BaseResponse<DietResponse>> = callbackFlow {
        dataStoreManager.accessToken.collect { accessToken ->
            accessToken.let {
                apiService.getDiet("Bearer "+accessToken!!,patientId).enqueue(CallBack(this.channel))
            }
        }
        awaitClose { close() }
    }.flowOn(ioDispatcher)

    fun saveDiet(dietRequest: DietRequest): Flow<BaseResponse<Void>> = callbackFlow {
        dataStoreManager.accessToken.collect { accessToken ->
            accessToken.let {
                apiService.saveDiet("Bearer "+accessToken!!,dietRequest).enqueue(CallBack(this.channel))
            }
        }
        awaitClose { close() }
    }.flowOn(ioDispatcher)
}