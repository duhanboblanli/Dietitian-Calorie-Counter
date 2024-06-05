package com.tez.dieticianpatientapp.service;

import com.tez.dieticianpatientapp.dto.DieticianDto;
import com.tez.dieticianpatientapp.dto.PatientDto;
import com.tez.dieticianpatientapp.entities.Dietician;
import com.tez.dieticianpatientapp.entities.Patient;
import com.tez.dieticianpatientapp.entities.User;
import com.tez.dieticianpatientapp.exception.NotUniqueTcknException;
import com.tez.dieticianpatientapp.exception.PatientNotMatchDieticianException;
import com.tez.dieticianpatientapp.exception.UserNotFoundException;
import com.tez.dieticianpatientapp.repository.PatientRepository;
import com.tez.dieticianpatientapp.security.UserDetailsImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PatientService {
    private final PatientRepository patientRepository;

    private final UserService userService;

    private final DieticianService dieticianService;

    public PatientService(PatientRepository patientRepository, UserService userService, DieticianService dieticianService) {
        this.patientRepository = patientRepository;
        this.userService = userService;
        this.dieticianService = dieticianService;
    }

    public Patient getPatientById(long id){
        return patientRepository.findById(id).orElseThrow(UserNotFoundException::new);
    }

    public ResponseEntity<PatientDto> savePatient(Patient patient){
        try {
            patientRepository.save(patient);
        } catch (DataIntegrityViolationException ex){
            throw new NotUniqueTcknException();
        }
        return ResponseEntity.status(HttpStatus.CREATED).body(new PatientDto(patient));
    }

    public Patient getPatientByTckn(String tckn){
        Optional<Patient> patient = patientRepository.findByUserTckn(tckn);
        if(patientRepository.findByUserTckn(tckn).isEmpty())
            throw new UserNotFoundException();
        return  patient.get();
    }

    public void bindDietician(String patientId){
        UserDetailsImpl dieticianUser = (UserDetailsImpl)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Dietician dietician = dieticianService.getDieticianByTckn(dieticianUser.getUsername());
        Patient patient = getPatientByTckn(patientId);
        patient.setDietician(dietician);
        patientRepository.save(patient);
    }

    public List<Patient> getPatientsByDietician(){
        UserDetailsImpl dieticianUser = (UserDetailsImpl)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Dietician dietician = dieticianService.getDieticianByTckn(dieticianUser.getUsername());
        List<Patient> patients = patientRepository.findByDieticianId(dietician.getId());
        return  patients;
    }
}
