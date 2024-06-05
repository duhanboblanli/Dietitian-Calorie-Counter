package com.example.dietitianapp.presentation.Detail

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.dietitianapp.domain.ViewState
import com.example.dietitianapp.model.BaseResponse
import com.example.dietitianapp.model.DietRequest
import com.example.dietitianapp.model.DietResponse
import com.example.dietitianapp.usecase.detail.PatientDetailUseCase
import com.example.dietitianapp.usecase.detail.SaveDietUseCase
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.launchIn
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.onEach
import javax.inject.Inject
@HiltViewModel
class DetailViewModel @Inject constructor(
    private val patientDetailUseCase: PatientDetailUseCase,
    private val saveDietUseCase: SaveDietUseCase
): ViewModel() {

    private val _uiStateGetDiet: MutableStateFlow<ViewState<BaseResponse<DietResponse>>>
            = MutableStateFlow(ViewState.Loading)
    val uiStateGetDiet = _uiStateGetDiet.asStateFlow()

    private val _uiStateSaveDiet: MutableStateFlow<ViewState<BaseResponse<Void>>>
            = MutableStateFlow(ViewState.Loading)
    val uiStateSaveDiet = _uiStateSaveDiet.asStateFlow()
    fun getDietOfPatient(patientId:String){
        patientDetailUseCase.execute(patientId).map {
            when(val responseData: BaseResponse<DietResponse> = it) {
                is BaseResponse.Success -> {
                    ViewState.Success(responseData)
                }
                is BaseResponse.Error -> {
                    ViewState.Error(responseData.error.message.toString())
                }
            }
        }.onEach {data ->
            _uiStateGetDiet.emit(data)
        }.launchIn(viewModelScope)
    }

    fun saveDiet(dietRequest: DietRequest){
        saveDietUseCase.execute(dietRequest).map {
            when(val responseData: BaseResponse<Void> = it) {
                is BaseResponse.Success -> {
                    ViewState.Success(responseData)
                }
                is BaseResponse.Error -> {
                    ViewState.Error(responseData.error.message.toString())
                }
            }
        }.onEach {data ->
            _uiStateSaveDiet.emit(data)
        }.launchIn(viewModelScope)
    }


}