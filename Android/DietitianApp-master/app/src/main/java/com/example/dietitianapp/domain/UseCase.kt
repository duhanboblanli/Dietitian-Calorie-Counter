package com.example.dietitianapp.domain

interface MultiParaMeterUseCase<In,Out> {
    fun execute(vararg params: In): Out
}

interface SingleParaMeterUseCase<In,Out> {
    fun execute(param: In): Out
}

interface NoParaMeterUseCase<Out> {
    fun execute(): Out
}