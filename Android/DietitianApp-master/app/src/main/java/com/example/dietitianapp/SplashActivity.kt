package com.example.dietitianapp

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.lifecycleScope
import com.example.dietitianapp.data.local.DataStoreManager
import com.example.dietitianapp.presentation.home.MainActivity
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import javax.inject.Inject
@AndroidEntryPoint
class SplashActivity : AppCompatActivity() {
    @Inject
    lateinit var dataStoreManager: DataStoreManager
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)
        CoroutineScope(Dispatchers.Main).launch {
            dataStoreManager.deleteAccessToken()  //tobe deleted
            delay(SPLASH_TIME)
            getUserId()
        }
    }
    private fun getUserId() {
        lifecycleScope.launch {
            dataStoreManager.accessToken.collect { accessToken ->
                accessToken?.let {
                    startActivity(MainActivity.callIntent(this@SplashActivity))
                } ?: run {
                    startActivity(AccountActivity.callIntent(this@SplashActivity))
                }
            }
        }
    }

    companion object {
        private const val SPLASH_TIME = 4000L
    }
}



