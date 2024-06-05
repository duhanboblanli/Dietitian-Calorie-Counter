package com.example.dietitianapp.presentation.home

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.dietitianapp.domain.ViewState
import com.example.dietitianapp.model.BaseResponse
import com.example.dietitianapp.model.Patient
import com.example.dietitianapp.usecase.home.ListPatientsUseCase
import com.example.dietitianapp.usecase.home.SavePatientUseCase
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asSharedFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.launchIn
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.onEach
import javax.inject.Inject

@HiltViewModel
class HomeViewModel @Inject constructor(
    private val listPatientsUseCase: ListPatientsUseCase,
    private val savePatientUseCase: SavePatientUseCase
) : ViewModel() {

    private val _uiStateListPatients: MutableSharedFlow<ViewState<BaseResponse<List<Patient>>>> =
        MutableSharedFlow()
    val uiStateListPatients = _uiStateListPatients.asSharedFlow()

    private val _uiStateSavePatient: MutableStateFlow<ViewState<BaseResponse<Void>>>
            = MutableStateFlow(ViewState.Loading)
    val uiStateSavePatient = _uiStateSavePatient.asStateFlow()
    fun getPatients(){
        listPatientsUseCase.execute().map {
            when(val responseData: BaseResponse<List<Patient>> = it) {
                is BaseResponse.Success -> {
                    ViewState.Success(responseData)
                }
                is BaseResponse.Error -> {
                    ViewState.Error(responseData.error.message.toString())
                }
            }
        }.onEach {data ->
            _uiStateListPatients.emit(data)
        }.launchIn(viewModelScope)
    }

    fun savePatient(patientId: String) {
        savePatientUseCase.execute(patientId).map {
            when(val responseData: BaseResponse<Void> = it) {
                is BaseResponse.Success -> {
                    ViewState.Success(responseData)
                }
                is BaseResponse.Error -> {
                    ViewState.Error(responseData.error.message.toString())
                }
            }
        }.onEach {data ->
            _uiStateSavePatient.emit(data)
        }.launchIn(viewModelScope)
    }
}