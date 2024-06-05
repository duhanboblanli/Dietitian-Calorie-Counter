package com.tez.dieticianpatientapp.controller;

import com.tez.dieticianpatientapp.dto.PatientDto;
import com.tez.dieticianpatientapp.entities.Patient;
import com.tez.dieticianpatientapp.service.PatientService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
public class PatientController {

    PatientService patientService;

    public PatientController(PatientService patientService) {
        this.patientService = patientService;
    }

    @GetMapping("api/v1/patients")
    public ResponseEntity<?> getPatient(@RequestHeader(value = "X-TCKN",required = false) String tckn) {
        return ResponseEntity.status(HttpStatus.OK).body(new PatientDto(patientService.getPatientByTckn(tckn)));
    }

    @PutMapping("api/v1/patients/{id}")
    public ResponseEntity<String> bindDietician(@PathVariable String id){
        patientService.bindDietician(id);
        return ResponseEntity.ok(null);
    }
}
