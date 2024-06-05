package com.example.dietitianapp.presentation.Detail

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.text.InputFilter
import android.text.InputType
import android.util.Log
import android.view.View
import android.widget.Toast
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.flowWithLifecycle
import androidx.lifecycle.lifecycleScope
import com.example.dietitianapp.R
import com.example.dietitianapp.databinding.ActivityDetailBinding
import com.example.dietitianapp.databinding.AddPatientViewBinding
import com.example.dietitianapp.domain.ViewState
import com.example.dietitianapp.model.BaseResponse
import com.example.dietitianapp.model.DietRequest
import com.example.dietitianapp.model.Patient
import com.wada811.viewbindingktx.viewBinding
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.launch

@AndroidEntryPoint
class DetailActivity : AppCompatActivity() {
    private val binding by viewBinding(ActivityDetailBinding::bind)
    private val viewModel: DetailViewModel by viewModels()
    lateinit var addPatientBinding: AddPatientViewBinding
    lateinit var patient: Patient
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_detail)
        addPatientBinding = binding.cvAddPatient.binding
        val intent = intent
        patient = intent.getSerializableExtra("patient") as Patient
        viewModel.getDietOfPatient(patient.id.toString())
        initListener()
        initObserver()
        initPatient(patient)
    }

    fun initListener(){
        with(binding){
            //finish activity
            ivBack.setOnClickListener {
                finish()
            }
            btnAddCalorie.setOnClickListener {
                with(addPatientBinding){
                    tvAddPatientCaption.text = resources.getString(R.string.add_calorie)
                    etNewPatient.hint=resources.getString(R.string.add_calorie_hint)
                    etNewPatient.inputType=InputType.TYPE_CLASS_NUMBER
                    etNewPatient.filters = arrayOf(InputFilter.LengthFilter(5))
                }
                cvAddPatient.visibility = View.VISIBLE
            }
            addPatientBinding.btnAddPatientAdd.setOnClickListener {
                val request = DietRequest(patient.id,addPatientBinding.etNewPatient.text.toString().toLong())
                viewModel.saveDiet(request)
            }
            addPatientBinding.btnAddPatientCancel.setOnClickListener{
                cvAddPatient.visibility = View.GONE
            }
        }
    }
    fun initPatient(patient: Patient) = with(binding){
        tvPatientName.text = buildString {
            append(patient.firstName)
            append(" ")
            append(patient.lastName)
        }
        tvProfileImage.text=patient.firstName[0].toString()
        tvPatientInfo.text = patient.id.toString()
    }
    fun initObserver()= with(viewModel) {
        lifecycleScope.launch {
            uiStateGetDiet.flowWithLifecycle(lifecycle)
                .collect { viewState ->
                    when (viewState) {
                        is ViewState.Success -> {
                            with(binding) {
                                val response = viewState.result as BaseResponse.Success
                                loadingView.visibility = View.GONE
                                Log.v("ViewState.Success", response.data.toString())
                                val data = response.data
                                tvIntakeCal.text= buildString {
                                    append(resources.getString(R.string.intakeCal))
                                    append(String.format("%.2f",data.intakeCal))
                                    append(resources.getString(R.string.kilocalorie))
                                }
                                tvIntakeCarbonhydrate.text= buildString {
                                    append(resources.getString(R.string.carbonhydrate))
                                    append(String.format("%.2f",data.intakeCarbohydrate))
                                    append(resources.getString(R.string.gram))
                                }

                                tvIntakeFat.text= buildString {
                                    append(resources.getString(R.string.fat))
                                    append(String.format("%.2f",data.intakeFat))
                                    append(resources.getString(R.string.gram))
                                }

                                tvIntakeProtein.text= buildString {
                                    append(resources.getString(R.string.protein))
                                    append(String.format("%.2f",data.intakeProtein))
                                    append(resources.getString(R.string.gram))
                                }
                                //total
                                tvTotalCal.text= buildString {
                                    append(resources.getString(R.string.totalCal))
                                    append(String.format("%.2f",data.totalCal))
                                    append(resources.getString(R.string.kilocalorie))
                                }
                                tvTotalCarbonhydrate.text= buildString {
                                    append(resources.getString(R.string.carbonhydrate))
                                    append(String.format("%.2f",data.totalCarbohydrate))
                                    append(resources.getString(R.string.gram))
                                }

                                tvTotalFat.text= buildString {
                                    append(resources.getString(R.string.fat))
                                    append(String.format("%.2f",data.totalFat))
                                    append(resources.getString(R.string.gram))
                                }

                                tvTotalProtein.text= buildString {
                                    append(resources.getString(R.string.protein))
                                    append(String.format("%.2f",data.totalProtein))
                                    append(resources.getString(R.string.gram))
                                }
                            }
                        }
                        is ViewState.Error ->{
                            Toast.makeText(this@DetailActivity,"Veri Alınamadı",Toast.LENGTH_LONG).show()
                            binding.loadingView.visibility = View.GONE

                        }
                        is ViewState.Loading ->{
                            binding.loadingView.visibility = View.VISIBLE
                        }
                    }
                }
        }
        lifecycleScope.launch {
            uiStateSaveDiet.flowWithLifecycle(lifecycle)
                .collect { viewState ->
                    when (viewState) {
                        is ViewState.Success -> {
                            Toast.makeText(this@DetailActivity,"Kalori Eklendi",Toast.LENGTH_LONG).show()
                            binding.loadingView.visibility = View.GONE

                        }
                        is ViewState.Error ->{
                            val response = viewState.error
                            Toast.makeText(this@DetailActivity,response,Toast.LENGTH_LONG).show()
                        }
                        is ViewState.Loading ->{
                            binding.loadingView.visibility = View.VISIBLE
                        }
                    }
                }

        }
    }
    companion object {
        fun callIntent(context: Context) = Intent(context, DetailActivity::class.java)
    }
}