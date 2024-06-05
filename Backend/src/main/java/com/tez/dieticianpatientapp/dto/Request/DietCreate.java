package com.tez.dieticianpatientapp.dto.Request;

import jakarta.validation.constraints.Min;

public record DietCreate(
        long patientId,
        long totalCal) {
}
