package com.example.dietitianapp.presentation.account

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.lifecycle.flowWithLifecycle
import androidx.lifecycle.lifecycleScope
import com.example.dietitianapp.R
import com.example.dietitianapp.data.local.DataStoreManager
import com.example.dietitianapp.databinding.FragmentRegister2Binding
import com.example.dietitianapp.domain.ViewState
import com.example.dietitianapp.model.BaseResponse
import com.example.dietitianapp.model.Register
import com.example.dietitianapp.presentation.home.MainActivity
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.launch
import javax.inject.Inject

@AndroidEntryPoint
class RegisterFragment : Fragment() {
    private val viewModel: AccountViewModel by viewModels()
    private lateinit var binding: FragmentRegister2Binding
    @Inject
    lateinit var dataStoreManager: DataStoreManager
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = FragmentRegister2Binding.inflate(layoutInflater)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        initObserver()
        initListener()
    }

    private fun validatePassword(password: String): Boolean {
        // En az bir büyük harf ve bir özel karakter içeriyor mu kontrol et
        val regex = Regex("^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@\$%^&*-]).{8,}\$")
        return password.matches(regex)
    }

    private fun initListener() {
        binding.apply {
            btnSignUp.setOnClickListener {
                Log.v("RegisterFragment", "btnSignUp.setOnClickListener")
                val tckn = binding.etTckn.text.toString()
                val password = binding.etPassword.text.toString()
                var validations = true
                if (etName.text.toString().isEmpty()) {
                    binding.tvInputName.error = getString(R.string.please_enter_your_name)
                    validations = false
                } else {
                    binding.tvInputName.isErrorEnabled = false
                }

                if (etSurname.text.toString().isEmpty()) {
                    binding.tvInputSurname.error = getString(R.string.please_enter_your_surname)
                    validations = false
                } else {
                    binding.tvInputSurname.isErrorEnabled = false
                }
                if (etTckn.text.toString().isEmpty()) {
                    binding.tvInputTckn.error =
                        getString(R.string.please_enter_your_tckn)
                    validations = false
                } else {
                    binding.tvInputTckn.isErrorEnabled = false
                }

                if (!validatePassword(password)) {
                    binding.tvInputPassword.error =
                        getString(R.string.your_password_must_contain_at_least_one_uppercase_letter_and_a_special_character)
                    validations = false
                } else {
                    binding.tvInputPassword.isErrorEnabled = false
                }
                if (!validations) {
                    return@setOnClickListener
                }
                val register = Register(
                    etTckn.text.toString(),
                    etPassword.text.toString(),
                    etName.text.toString(),
                    etSurname.text.toString()
                )
                viewModel.setRegister(register)
            }
        }
    }

    private fun initObserver() = with(viewModel) {
        viewLifecycleOwner.lifecycleScope.launch {
            uiStateLogin.flowWithLifecycle(viewLifecycleOwner.lifecycle)
                .collect { viewState ->
                    when (viewState) {
                        is ViewState.Success -> {
                            val response = viewState.result as BaseResponse.Success
                            Log.v("ViewState.Success", response.data.toString())
                            dataStoreManager.saveToken(response.data.accessToken)
                            startActivity(MainActivity.callIntent(requireContext()))
                            Log.d("CreateAccountFragment", response.data.toString())
                        }

                        is ViewState.Error -> {
                            val response = viewState.error
                            Log.d("CreateAccountFragment", "Error: $response")
                        }

                        is ViewState.Loading -> {
                            Log.d("CreateAccountFragment", "Loading")
                        }
                    }
                }
        }
    }
}