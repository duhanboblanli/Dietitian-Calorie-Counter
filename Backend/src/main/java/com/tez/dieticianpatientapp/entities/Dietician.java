package com.tez.dieticianpatientapp.entities;

import com.tez.dieticianpatientapp.service.PatientService;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.context.annotation.Lazy;

import java.util.List;

@Table(name = "dietician")
@Entity
@Getter
@Setter
@NoArgsConstructor
public class Dietician {

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

    @OneToMany(mappedBy="dietician")
    private List<Patient> patients;

    public Dietician(String firstName, String lastName, User user) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.user = user;
    }
}
