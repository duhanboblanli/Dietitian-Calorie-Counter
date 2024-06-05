package com.example.dietitianapp.usecase.home

import com.example.dietitianapp.model.BaseResponse
import com.example.dietitianapp.repository.DieticianRepository
import com.example.dietitianapp.domain.SingleParaMeterUseCase
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject

class SavePatientUseCase @Inject constructor(
    private val dietitianRepository: DieticianRepository
): SingleParaMeterUseCase<String,Flow<BaseResponse<Void>>> {
    override fun execute(param: String): Flow<BaseResponse<Void>> = dietitianRepository.savePatient(param)
}