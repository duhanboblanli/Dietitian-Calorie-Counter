package com.tez.dieticianpatientapp.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.apachecommons.CommonsLog;

@Entity
@Table(name = "patient")
@Getter
@Setter
@NoArgsConstructor
public class Patient {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @Column(name = "first_name")
    String firstName;

    @Column(name = "last_name")
    String lastName;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "tckn", referencedColumnName = "user_tckn")
    User user;

    @ManyToOne
    @JoinColumn(name = "dietician_id")
    Dietician dietician;

    public Patient(String firstName, String lastName, User user) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.user = user;
    }
}
