package com.example.dietitianapp.presentation.home

import android.os.Bundle
import android.text.Editable
import android.text.InputFilter
import android.text.TextWatcher
import android.util.Log
import android.view.View
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.fragment.app.viewModels
import androidx.lifecycle.flowWithLifecycle
import androidx.lifecycle.lifecycleScope
import androidx.navigation.navGraphViewModels
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import com.example.dietitianapp.R
import com.example.dietitianapp.data.local.DataStoreManager
import com.example.dietitianapp.databinding.AddPatientViewBinding
import com.example.dietitianapp.databinding.FragmentPatientsBinding
import com.example.dietitianapp.databinding.ItemPatientBinding
import com.example.dietitianapp.domain.ViewState
import com.example.dietitianapp.model.BaseResponse
import com.example.dietitianapp.model.Patient
import com.example.dietitianapp.presentation.Detail.DetailActivity
import com.example.dietitianapp.presentation.adapter.SingleRecylerAdapter
import com.wada811.viewbindingktx.viewBinding
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.launch
import javax.inject.Inject

@AndroidEntryPoint
class PatientsFragment : Fragment(R.layout.fragment_patients), SwipeRefreshLayout.OnRefreshListener{
    private val binding by this.viewBinding(FragmentPatientsBinding::bind)
    private val viewModel: HomeViewModel by activityViewModels()
    @Inject
    lateinit var dataStoreManager: DataStoreManager
    lateinit var addPatientBinding: AddPatientViewBinding
    private var mTextWatcher: TextWatcher? = null
    val activity:MainActivity by lazy {
        requireActivity() as MainActivity
    }
    private var patientList:List<Patient> = listOf()
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        addPatientBinding = binding.cvAddPatient.binding
        activity.binding.swipe.setOnRefreshListener(this)
        binding.loadingView.visibility = View.VISIBLE
        viewModel.getPatients()
        initObserver()
        initListener()
    }

    private fun initListener() {
        with(binding){
            ivAddPatient.setOnClickListener {
                cvAddPatient.visibility = View.VISIBLE
            }
        }
        with(addPatientBinding){
            etNewPatient.inputType= android.text.InputType.TYPE_CLASS_NUMBER
            etNewPatient.filters = arrayOf(InputFilter.LengthFilter(11))
            btnAddPatientAdd.setOnClickListener {
                val patientId = etNewPatient.text.toString()
                viewModel.savePatient(patientId)
                binding.cvAddPatient.visibility = View.GONE

            }
            btnAddPatientCancel.setOnClickListener {
                binding.cvAddPatient.visibility = View.GONE
            }
        }
        textChanger()
    }

    private fun initObserver() = with(viewModel){
        viewLifecycleOwner.lifecycleScope.launch {
            uiStateListPatients.flowWithLifecycle(viewLifecycleOwner.lifecycle)
                .collect { viewState ->
                    activity.binding.swipe.isRefreshing = false
                    when (viewState) {
                        is ViewState.Success -> {
                            with(binding) {
                                val response = viewState.result as BaseResponse.Success
                                loadingView.visibility = View.GONE
                                Log.v("ViewState.Success", response.data.toString())
                                patientList = response.data
                                patientListAdapter.data = patientList
                                rvPatient.layoutManager = LinearLayoutManager(
                                    context,
                                    LinearLayoutManager.VERTICAL,
                                    false
                                )
                                rvPatient.adapter = patientListAdapter
                            }
                        }

                        is ViewState.Error -> {
                            val responseError = viewState.error
                            binding.loadingView.visibility = View.GONE
                            with(binding) {
                                Log.v("ViewState.Error", responseError)
                                val patientList: MutableList<Patient> = mutableListOf()
                                patientList.add(Patient(1, "Dummy Client", "Surname"))
                                patientListAdapter.data = patientList
                                rvPatient.layoutManager = LinearLayoutManager(
                                    context,
                                    LinearLayoutManager.VERTICAL,
                                    false
                                )
                                rvPatient.adapter = patientListAdapter
                            }
                        }

                        is ViewState.Loading -> {
                            Log.v("ViewState.Loading", "ViewState.Loading")
                            binding.loadingView.visibility = View.VISIBLE
                        }
                    }
                }
        }
        viewLifecycleOwner.lifecycleScope.launch {
            uiStateSavePatient.flowWithLifecycle(viewLifecycleOwner.lifecycle)
                .collect { viewState ->
                    when (viewState) {
                        is ViewState.Success -> {
                            val response = viewState.result as BaseResponse.Success
                            viewModel.getPatients()
                            Log.v("ViewState.Success","Is Success Triggered")
                        }
                        is ViewState.Error -> {
                            val responseError = viewState.error
                            viewModel.getPatients()
                            Log.v("ViewState.Error", responseError)
                        }
                        is ViewState.Loading -> {
                            Log.v("ViewState.Loading", "ViewState.Loading")
                        }
                    }
                }
        }
    }
    private val patientListAdapter = SingleRecylerAdapter<ItemPatientBinding, Patient>(
        { inflater, _, _ ->
            ItemPatientBinding.inflate(
                inflater,
                binding.rvPatient,
                false
            )
        },
        { cardItemBinding, patient ->
            with(cardItemBinding) {
                tvProfileImage.text = patient.firstName[0].toString()
                tvPatientName.text = patient.firstName + " " + patient.lastName
                tvPatientInfo.text = patient.id.toString()

                cvCardLayout.setOnClickListener {
                    val intent=DetailActivity.callIntent(requireContext())
                    intent.putExtra("patient", patient)
                    startActivity(intent)
                }
            }
        }
    )

    override fun onRefresh() {
        activity.binding.swipe.isRefreshing = true
        viewModel.getPatients()
    }
    private fun textChanger() {
        mTextWatcher = object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence, start: Int, count: Int, after: Int) {}
            override fun onTextChanged(s: CharSequence, start: Int, before: Int, count: Int) {
                if (s.length >= 2) {
                    patientListAdapter.data = patientList.filter {
                        it.firstName.contains(s.toString().lowercase()) || it.lastName.contains(s.toString().lowercase())
                    }
                    binding.rvPatient.adapter = patientListAdapter
                }else{
                    patientListAdapter.data = patientList
                    binding.rvPatient.adapter = patientListAdapter
                }
            }

            override fun afterTextChanged(s: Editable) {}
        }
        binding.etSearchbar.addTextChangedListener(mTextWatcher)
    }
}