package com.example.dietitianapp.repository

import com.example.dietitianapp.data.local.DataStoreManager
import com.example.dietitianapp.data.remote.ApiService
import com.example.dietitianapp.data.remote.CallBack
import com.example.dietitianapp.di.IoDispatcher
import com.example.dietitianapp.model.BaseResponse
import com.example.dietitianapp.model.Patient
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.channels.awaitClose
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.callbackFlow
import kotlinx.coroutines.flow.flowOn
import javax.inject.Inject

class DieticianRepository @Inject constructor(
    private val apiService: ApiService,
    @IoDispatcher private val ioDispatcher: CoroutineDispatcher,
    var dataStoreManager: DataStoreManager
) {
    fun getPatients(): Flow<BaseResponse<List<Patient>>> = callbackFlow {
        dataStoreManager.accessToken.collect { accessToken ->
            accessToken.let{
                apiService.getPatients("Bearer "+accessToken!!).enqueue(CallBack(this.channel))
            }
        }
        awaitClose { close() }
    }.flowOn(ioDispatcher)

    fun savePatient(id:String): Flow<BaseResponse<Void>> = callbackFlow {
        dataStoreManager.accessToken.collect { accessToken ->
            accessToken.let{
                apiService.savePatient("Bearer "+accessToken!!,id).enqueue(CallBack(this.channel))
            }
        }
        awaitClose { close() }
    }.flowOn(ioDispatcher)
}