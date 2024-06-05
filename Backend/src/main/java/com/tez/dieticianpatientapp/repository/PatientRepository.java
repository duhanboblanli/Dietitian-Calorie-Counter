package com.tez.dieticianpatientapp.repository;

import com.tez.dieticianpatientapp.entities.Dietician;
import com.tez.dieticianpatientapp.entities.Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
@Repository
public interface PatientRepository extends JpaRepository<Patient,Long> {
    Optional<Patient> findByUserTckn(String userTckn);
    List<Patient> findByDieticianId(Long dieticianId);
}
