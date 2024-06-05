package com.tez.dieticianpatientapp.dto;

import com.tez.dieticianpatientapp.entities.Diet;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@AllArgsConstructor
public class DietDto{
    long dietId;

    double totalCal;
    double intakeCal;

    double totalCarbohydrate;
    double totalFat;
    double totalProtein;

    double intakeCarbohydrate;
    double intakeFat;
    double intakeProtein;
    LocalDate dietDate;

     public DietDto(Diet diet){
         dietId = diet.getId();
         totalCal = diet.getTotalCal();
         totalCarbohydrate = diet.getTotalCarbohydrate();
         totalFat = diet.getTotalFat();
         totalProtein = diet.getTotalProtein();
         intakeCarbohydrate = diet.getIntakeCarbohydrate();
         intakeFat = diet.getIntakeFat();
         intakeProtein = diet.getIntakeProtein();
         dietDate = diet.getDietDate();
         intakeCal = diet.getIntakeCal();
    }
}
