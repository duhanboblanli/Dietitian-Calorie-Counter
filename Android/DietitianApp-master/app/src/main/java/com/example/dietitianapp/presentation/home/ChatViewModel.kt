package com.example.dietitianapp.presentation.home

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.dietitianapp.domain.ViewState
import com.example.dietitianapp.model.BaseResponse
import com.example.loginpage.model.Message
import com.google.firebase.Timestamp
import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import java.util.Calendar
import java.util.Date
import java.util.UUID
import javax.inject.Inject

@HiltViewModel
class ChatViewModel @Inject constructor():ViewModel() {
    val messageList = MutableLiveData<List<Message>>()
    private val db: FirebaseFirestore = Firebase.firestore
    val chatViewStatus = MutableLiveData<Int>()
    fun getMessages(){
        chatViewStatus.value= 0 //loading
        db.collection("messages")
            .addSnapshotListener{result,error ->
                val documents = result?.documents ?: run {
                    chatViewStatus.value = 1 //error
                    return@addSnapshotListener
                }
                val result = documents.map{document->
                    document.data?.let {
                        Message(
                            it["id"].toString(),
                            it["text"].toString(),
                            it["received"] as Boolean,
                            it["timestamp"] as Timestamp
                        )
                    }?:run{
                        chatViewStatus.value = 1 //error
                        return@addSnapshotListener
                    }
                }
                messageList.postValue(result)
                chatViewStatus.value = 2 //success
            }
    }
    fun addMessage(messageText: String):Boolean{
        val message = Message(UUID.randomUUID().toString(),messageText,true, Timestamp(Calendar.getInstance().time))
        var isSuccess = true
        db.collection("messages")
            .add(message)
            .addOnSuccessListener {
            }
            .addOnFailureListener {
                isSuccess = false
            }
        return isSuccess
    }

}