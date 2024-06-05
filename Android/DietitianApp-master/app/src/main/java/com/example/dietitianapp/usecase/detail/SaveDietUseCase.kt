package com.example.dietitianapp.usecase.detail

import com.example.dietitianapp.domain.SingleParaMeterUseCase
import com.example.dietitianapp.model.BaseResponse
import com.example.dietitianapp.model.DietRequest
import com.example.dietitianapp.repository.DietRepository
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject

class SaveDietUseCase @Inject constructor(
    private val dietRepository: DietRepository
): SingleParaMeterUseCase<DietRequest,Flow<BaseResponse<Void>>> {
    override fun execute(param:DietRequest) = dietRepository.saveDiet(param)
}