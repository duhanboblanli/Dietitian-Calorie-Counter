package com.tez.dieticianpatientapp.dto.Request;

public record UpdateDietCalorieIntake(
        double intakeCal,
        double intakeCarbohydrate,
        double intakeFat,
        double intakeProtein) {
}
