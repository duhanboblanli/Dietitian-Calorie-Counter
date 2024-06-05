package com.example.dietitianapp.presentation.home

import android.content.Context
import android.content.Context.INPUT_METHOD_SERVICE
import android.os.Bundle
import android.util.Log
import android.view.View
import android.view.inputmethod.InputMethodManager
import android.widget.Toast
import androidx.core.content.ContextCompat.getSystemService
import androidx.core.content.getSystemService
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.dietitianapp.R
import com.example.dietitianapp.databinding.FragmentChatBinding
import com.example.dietitianapp.presentation.adapter.MessageAdapter
import com.example.loginpage.model.Message
import com.google.firebase.Timestamp
import com.wada811.viewbindingktx.viewBinding
import dagger.hilt.android.AndroidEntryPoint
import java.util.Date
import java.util.UUID


@AndroidEntryPoint
class ChatFragment : Fragment(R.layout.fragment_chat) {
    private val binding by this.viewBinding(FragmentChatBinding::bind)
    private val viewModel: ChatViewModel by viewModels()
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val messageList = arrayListOf(
            Message(UUID.randomUUID().toString(),"Merhaba. Yeni Diet programınızı gönderdim",false, Timestamp(Date())),
            Message(UUID.randomUUID().toString(),"Tamamdır, Teşekkür Ederim",true, Timestamp(Date()))
        )
        val messageAdapter = MessageAdapter(this.requireContext(),messageList)
        initObserver()
        viewModel.getMessages()
        with(binding){
            rvChat.layoutManager = LinearLayoutManager(requireContext())
            rvChat.adapter = messageAdapter
            rvChat.scrollToPosition(messageAdapter.itemCount -1)
            btnSend.setOnClickListener{
                val message = etChat.text.toString()
                if(message.isNotEmpty()){
                    val result= viewModel.addMessage(message)
                    if (!result){
                        Toast.makeText(requireContext(),"Mesaj Gönderilemedi",Toast.LENGTH_SHORT).show()
                    }
                    rvChat.scrollToPosition(messageAdapter.itemCount -1)
                }
                etChat.setText("")
                try {
                    val imm:InputMethodManager = requireActivity().getSystemService(INPUT_METHOD_SERVICE) as InputMethodManager
                    imm.hideSoftInputFromWindow(binding.root.applicationWindowToken,0)
                } catch (e: Exception) {
                    Log.v("Chat Fragment","Keyboard hide error")
                }
                messageAdapter.notifyDataSetChanged()
            }
        }
    }

    fun initObserver() {
        val messages = Observer<List<Message>> {
            val adapter =MessageAdapter(requireContext(), it.toList().sortedBy { it.timestamp })
            binding.rvChat.adapter = adapter
            binding.rvChat.scrollToPosition(adapter.itemCount -1)
        }
        viewModel.messageList.observe(viewLifecycleOwner, messages)

        val chatViewStatus = Observer<Int> {
            when(it){
                0 -> {
                    binding.loadingView.visibility = View.VISIBLE
                    binding.rvChat.visibility = View.GONE
                }
                1 -> {
                    binding.loadingView.visibility = View.GONE
                    binding.rvChat.visibility = View.GONE
                }
                2 -> {
                    binding.loadingView.visibility = View.GONE
                    binding.rvChat.visibility = View.VISIBLE
                }
            }
        }
        viewModel.chatViewStatus.observe(viewLifecycleOwner, chatViewStatus)
    }
}