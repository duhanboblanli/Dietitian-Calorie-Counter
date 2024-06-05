package com.example.dietitianapp.presentation.custom

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import android.widget.FrameLayout
import com.example.dietitianapp.databinding.AddPatientViewBinding

class AddPatientView @JvmOverloads constructor(
    context: Context, attrs: AttributeSet? = null, defStyleAttr: Int = 0
) : FrameLayout(context, attrs, defStyleAttr) {
    val binding: AddPatientViewBinding
    init {
        val _binding = AddPatientViewBinding.inflate(LayoutInflater.from(context))
        addView(_binding.root)
        binding = _binding
    }

    private fun initializeView() {
//        View.inflate(context, R.layout.add_patient_view, this)
    }
}