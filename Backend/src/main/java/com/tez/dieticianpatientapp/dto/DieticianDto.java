package com.tez.dieticianpatientapp.dto;

import com.tez.dieticianpatientapp.entities.Dietician;
import jakarta.persistence.Column;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class DieticianDto {

    Long id;

    String firstName;

    String lastName;

    UserDto user;

    public DieticianDto(Dietician dietician){
        id = dietician.getId();
        firstName = dietician.getFirstName();
        lastName = dietician.getLastName();
        user = new UserDto(dietician.getUser());
    }
}
