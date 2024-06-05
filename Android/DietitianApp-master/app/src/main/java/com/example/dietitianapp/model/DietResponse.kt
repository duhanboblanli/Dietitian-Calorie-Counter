package com.example.dietitianapp.model

data class DietResponse(
    val dietId: Long,
    val totalCal: Double,
    val intakeCal: Double,
    val totalCarbohydrate: Double,
    val totalFat: Double,
    val totalProtein: Double,
    val intakeCarbohydrate: Double,
    val intakeFat: Double,
    val intakeProtein: Double,
    val dietDate: String
)
