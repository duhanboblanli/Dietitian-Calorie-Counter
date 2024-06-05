package com.example.dietitianapp

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.example.dietitianapp.databinding.ActivityAccountBinding
import com.wada811.viewbindingktx.viewBinding
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class AccountActivity : AppCompatActivity() {
    val binding by viewBinding(ActivityAccountBinding::bind)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_account)

    }

    companion object {
        fun callIntent(context: Context) = Intent(context, AccountActivity::class.java)
    }
}