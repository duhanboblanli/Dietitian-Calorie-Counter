package com.tez.dieticianpatientapp.controller;

import com.tez.dieticianpatientapp.dto.DieticianDto;
import com.tez.dieticianpatientapp.dto.PatientDto;
import com.tez.dieticianpatientapp.entities.Patient;
import com.tez.dieticianpatientapp.service.DieticianService;
import com.tez.dieticianpatientapp.service.PatientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
public class DieticianController {

    @Autowired
    DieticianService dieticianService;

    @Autowired
    PatientService patientService;

    @GetMapping("api/v1/dieticians/{id}")
    public ResponseEntity<DieticianDto> getDietician(@PathVariable long id){
        return ResponseEntity.ok(new DieticianDto(dieticianService.getDieticianById(id)));
    }

    @GetMapping("api/v1/dieticians/patients")
    public ResponseEntity<List<PatientDto>> getPatientsByDietician() {
        List<Patient> patients = patientService.getPatientsByDietician();
        List<PatientDto> patientDtos = patients.stream()
                .map(PatientDto::new)
                .collect(Collectors.toList());
        return ResponseEntity.ok(patientDtos);
    }

}
