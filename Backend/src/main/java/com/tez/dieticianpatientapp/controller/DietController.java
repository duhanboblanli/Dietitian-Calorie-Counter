package com.tez.dieticianpatientapp.controller;

import com.tez.dieticianpatientapp.dto.DietDto;
import com.tez.dieticianpatientapp.dto.Request.DietCreate;
import com.tez.dieticianpatientapp.dto.Request.UpdateDietCalorieIntake;
import com.tez.dieticianpatientapp.entities.Diet;
import com.tez.dieticianpatientapp.entities.Dietician;
import com.tez.dieticianpatientapp.security.UserDetailsImpl;
import com.tez.dieticianpatientapp.service.DietService;
import com.tez.dieticianpatientapp.service.DieticianService;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@RestController
@AllArgsConstructor
public class DietController {
    private final DietService dietService;

    @PostMapping("api/v1/diet")
    public ResponseEntity<?> saveDiet(@RequestBody DietCreate dietCreate){
        dietService.saveDiet(dietCreate);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @GetMapping("api/v1/diet")
    public ResponseEntity<DietDto> getDiet(@RequestParam(name = "patientId") long patientId){
        return new ResponseEntity<>(new DietDto(dietService.getDiet(patientId)),HttpStatus.OK);
    }

    @PutMapping("api/v1/diet")
    public ResponseEntity<?> updateIntake(@RequestBody UpdateDietCalorieIntake dietIntake){
        dietService.updateCalorieIntake(dietIntake);
        return new ResponseEntity<>(HttpStatus.OK);
    }

}
