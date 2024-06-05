package com.example.dietitianapp.presentation.account


import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.dietitianapp.domain.ViewState
import com.example.dietitianapp.model.BaseResponse
import com.example.dietitianapp.model.Login
import com.example.dietitianapp.model.Register
import com.example.dietitianapp.model.TokenResponse
import com.example.dietitianapp.usecase.user.LoginUseCase
import com.example.dietitianapp.usecase.user.RegisterUseCase
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.flow.launchIn
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.onEach
import javax.inject.Inject

@HiltViewModel
class AccountViewModel @Inject constructor(
    private val loginUseCase: LoginUseCase,
    private val registerUseCase: RegisterUseCase
): ViewModel() {

    private val _uiStateLogin: MutableStateFlow<ViewState<BaseResponse<TokenResponse>>> =
        MutableStateFlow(ViewState.Loading)
    val uiStateLogin = _uiStateLogin.asStateFlow()

    fun setLogin(login: Login) {
        loginUseCase.execute(login).map {
            when(val responseData: BaseResponse<TokenResponse> = it) {
                is BaseResponse.Success -> {
                    ViewState.Success(responseData)
                }
                is BaseResponse.Error -> {
                    ViewState.Error(responseData.error.message.toString())
                }
            }
        }.onEach { data ->
            _uiStateLogin.emit(data)
        }.catch {
            _uiStateLogin.emit(ViewState.Error(it.message.toString()))
        }.launchIn(viewModelScope)  //viewModelScope is a predefined scope that is tied to the lifecycle of the ViewModel. When the ViewModel is cleared, the scope is cancelled automatically.
    }

    fun setRegister(register: Register) {
        registerUseCase.execute(register).map {
            when(val responseData: BaseResponse<TokenResponse> = it) {
                is BaseResponse.Success -> {
                    ViewState.Success(responseData)
                }
                is BaseResponse.Error -> {
                    ViewState.Error(responseData.error.message.toString())
                }
            }
        }.onEach { data ->
            _uiStateLogin.emit(data)
        }.catch {
            _uiStateLogin.emit(ViewState.Error(it.message.toString()))
        }.launchIn(viewModelScope)
    }


}