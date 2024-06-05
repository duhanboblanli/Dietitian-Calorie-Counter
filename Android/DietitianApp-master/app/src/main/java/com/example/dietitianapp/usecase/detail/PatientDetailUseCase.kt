package com.example.dietitianapp.usecase.detail

import com.example.dietitianapp.domain.NoParaMeterUseCase
import com.example.dietitianapp.domain.SingleParaMeterUseCase
import com.example.dietitianapp.model.BaseResponse
import com.example.dietitianapp.model.DietResponse
import com.example.dietitianapp.model.Patient
import com.example.dietitianapp.repository.DietRepository
import com.example.dietitianapp.repository.DieticianRepository
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject

class PatientDetailUseCase @Inject constructor(
    private val dietRepository: DietRepository
): SingleParaMeterUseCase<String,Flow<BaseResponse<DietResponse>>> {
    override fun execute(param:String) = dietRepository.getDiet(param)
}