package com.tez.dieticianpatientapp.dto;

import com.tez.dieticianpatientapp.entities.Patient;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class PatientDto {

    Long id;

    String firstName;

    String lastName;

    public PatientDto(Patient patient) {
        this.id = patient.getId();
        this.firstName = patient.getFirstName();
        this.lastName = patient.getLastName();
    }
}
