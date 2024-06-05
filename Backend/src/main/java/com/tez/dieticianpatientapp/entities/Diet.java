package com.tez.dieticianpatientapp.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

@Table(name = "diets")
@Entity
@Getter
@Setter
@NoArgsConstructor
public class Diet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @OneToOne()
    @JoinColumn(name = "patient", referencedColumnName = "id")
    Patient patient;

    @ManyToOne
    @JoinColumn(name = "dietician", referencedColumnName = "id")
    Dietician dietician;


    double totalCal;
    double intakeCal;

    double totalCarbohydrate;
    double totalFat;
    double totalProtein;

    double intakeCarbohydrate;
    double intakeFat;
    double intakeProtein;
    LocalDate dietDate;


    public Diet(Patient patient, Dietician dietician, double totalCal, double totalCarbohydrate, double totalFat, double totalProtein) {
        this.patient = patient;
        this.dietician = dietician;
        this.totalCal = totalCal;
        this.totalCarbohydrate = totalCarbohydrate;
        this.totalFat = totalFat;
        this.totalProtein = totalProtein;
        dietDate = LocalDate.now();
    }



    public Diet(Patient patient, Dietician dietician, double totalCal) {
        this.patient = patient;
        this.dietician = dietician;
        this.totalCal = totalCal;
        dietDate = LocalDate.now();
    }
}
