package com.tez.dieticianpatientapp.repository;

import com.tez.dieticianpatientapp.entities.Diet;
import com.tez.dieticianpatientapp.entities.Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
@Repository
public interface DietRepository extends JpaRepository<Diet,Long> {
    Optional<Diet> findByPatientId(Long patientId);
}
