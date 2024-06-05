package com.example.dietitianapp.usecase.home

import com.example.dietitianapp.model.BaseResponse
import com.example.dietitianapp.model.Patient
import com.example.dietitianapp.repository.DieticianRepository
import com.example.dietitianapp.domain.NoParaMeterUseCase
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject

class ListPatientsUseCase @Inject constructor(
    private val dietitianRepository: DieticianRepository
): NoParaMeterUseCase<Flow<BaseResponse<List<Patient>>>> {
    override fun execute():Flow<BaseResponse<List<Patient>>> = dietitianRepository.getPatients()
}