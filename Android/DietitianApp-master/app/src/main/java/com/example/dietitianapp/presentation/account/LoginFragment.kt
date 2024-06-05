package com.example.dietitianapp.presentation.account

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.View
import androidx.fragment.app.viewModels
import androidx.lifecycle.flowWithLifecycle
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import com.example.dietitianapp.presentation.home.MainActivity
import com.example.dietitianapp.R
import com.example.dietitianapp.data.local.DataStoreManager
import com.example.dietitianapp.databinding.FragmentLoginBinding
import com.example.dietitianapp.model.BaseResponse
import com.example.dietitianapp.model.Login
import com.example.dietitianapp.domain.ViewState
import com.wada811.viewbindingktx.viewBinding
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.launch
import javax.inject.Inject

@AndroidEntryPoint
class LoginFragment : Fragment(R.layout.fragment_login) {
    private val binding by this.viewBinding(FragmentLoginBinding::bind)
    private val viewModel: AccountViewModel by viewModels()  //by ile birkere oluşturulur ve her seferinde çağrılır.
    @Inject
    lateinit var dataStoreManager: DataStoreManager
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        initObserver()
        initListener()
    }

    private fun initListener() = with(binding) {
        btLogin.setOnClickListener {
            binding.loadingView.visibility = View.VISIBLE
            viewModel.setLogin(Login(binding.etTckn.text.toString(), binding.etPassword.text.toString()))
        }
        btRegister.setOnClickListener {
            findNavController().navigate(R.id.action_loginFragment_to_registerFragment)
        }
    }

    private fun initObserver() = with(viewModel){
        viewLifecycleOwner.lifecycleScope.launch {
            uiStateLogin.flowWithLifecycle(viewLifecycleOwner.lifecycle)
                .collect { viewState ->
                    when (viewState) {
                        is ViewState.Success -> {
                            val response = viewState.result as BaseResponse.Success
                            binding.loadingView.visibility = View.GONE
                            Log.v("ViewState.Success", response.data.toString())
                            dataStoreManager.saveToken(response.data.accessToken)
                            startActivity(MainActivity.callIntent(requireContext()))
                        }

                        is ViewState.Error -> {
                            val responseError = viewState.error
                            binding.loadingView.visibility = View.GONE
                            Log.v("ViewState.Error", responseError)
                        }

                        is ViewState.Loading -> {
                            Log.v("ViewState.Loading", "ViewState.Loading")
                        }
                    }
                }
        }

    }

}