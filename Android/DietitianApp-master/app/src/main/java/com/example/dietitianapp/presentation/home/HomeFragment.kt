package com.example.dietitianapp.presentation.home

import android.os.Bundle
import android.util.Log
import android.view.View
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.fragment.app.viewModels
import androidx.lifecycle.flowWithLifecycle
import androidx.lifecycle.lifecycleScope
import androidx.navigation.NavController
import androidx.navigation.fragment.findNavController
import androidx.navigation.navGraphViewModels
import androidx.navigation.ui.NavigationUI
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import com.example.dietitianapp.R
import com.example.dietitianapp.data.local.DataStoreManager
import com.example.dietitianapp.databinding.FragmentHomeBinding
import com.example.dietitianapp.domain.ViewState
import com.example.dietitianapp.model.BaseResponse
import com.example.dietitianapp.model.Patient
import com.wada811.viewbindingktx.viewBinding
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.launch
import javax.inject.Inject
@AndroidEntryPoint
class HomeFragment : Fragment(R.layout.fragment_home),SwipeRefreshLayout.OnRefreshListener {
    private val binding by this.viewBinding(FragmentHomeBinding::bind)
    private val viewModel: HomeViewModel by activityViewModels()  //by ile birkere oluşturulur ve her seferinde çağrılır.
    @Inject
    lateinit var dataStoreManager: DataStoreManager
    val activity:MainActivity by lazy {
        requireActivity() as MainActivity
    }
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        activity.binding.swipe.setOnRefreshListener(this)
        binding.loadingView.visibility = View.VISIBLE
        viewModel.getPatients()
        initObserver()
        initListener()
    }
    override fun onRefresh() {
        Log.v("HomeFragment", "refresh")
        activity.binding.swipe.isRefreshing = false
    }

    private fun initObserver() = with(viewModel) {
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
                                tvPatientCount.text = response.data.size.toString()
                            }
                        }

                        is ViewState.Error -> {
                            val responseError = viewState.error
                            binding.loadingView.visibility = View.GONE
                        }

                        is ViewState.Loading -> {
                            Log.v("ViewState.Loading", "ViewState.Loading")
                            binding.loadingView.visibility = View.VISIBLE
                        }
                    }
                }
        }
    }
    fun initListener(){
        with(binding){
            cvPatientCount.setOnClickListener {
                activity.binding.bottomNavigation.selectedItemId = R.id.patientsFragment
            }
            cvNewMessageCount.setOnClickListener {
                activity.binding.bottomNavigation.selectedItemId = R.id.chatFragment
            }
        }
    }


}