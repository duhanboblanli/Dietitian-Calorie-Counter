package com.example.loginpage.model

import com.google.firebase.Timestamp

data class Message(
    val id:String,
    val text:String?, val received:Boolean?,
    val timestamp: Timestamp
)
