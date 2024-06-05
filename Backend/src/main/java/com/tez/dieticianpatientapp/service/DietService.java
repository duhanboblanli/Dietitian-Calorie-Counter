package com.tez.dieticianpatientapp.service;

import com.tez.dieticianpatientapp.dto.Request.DietCreate;
import com.tez.dieticianpatientapp.dto.Request.UpdateDietCalorieIntake;
import com.tez.dieticianpatientapp.entities.Diet;
import com.tez.dieticianpatientapp.entities.Dietician;
import com.tez.dieticianpatientapp.entities.Patient;
import com.tez.dieticianpatientapp.exception.DietNotFoundException;
import com.tez.dieticianpatientapp.exception.PatientNotMatchDieticianException;
import com.tez.dieticianpatientapp.repository.DietRepository;
import com.tez.dieticianpatientapp.security.UserDetailsImpl;
import lombok.AllArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
@AllArgsConstructor
public class DietService {

    private DietRepository repository;
    DieticianService dieticianService;

    PatientService patientService;

    public void saveDiet(DietCreate dietCreate){
        UserDetailsImpl dieticianUser = (UserDetailsImpl) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Dietician dietician = dieticianService.getDieticianByTckn(dieticianUser.getUsername());
        Patient patient = patientService.getPatientById(dietCreate.patientId());
        if(patient.getDietician() == null || !Objects.equals(patient.getDietician().getId(), dietician.getId()))
            throw new PatientNotMatchDieticianException();
        var existingDiet = getDiet(dietCreate.patientId());
        List<Double> calValues = convertTotalCaltoGramValues(dietCreate.totalCal());
        if(existingDiet !=null){
            existingDiet.setTotalCal(dietCreate.totalCal());
            existingDiet.setTotalCarbohydrate(calValues.get(0));
            existingDiet.setTotalFat(calValues.get(1));
            existingDiet.setTotalProtein(calValues.get(2));
            repository.save(existingDiet);
        }else{
            Diet diet = new Diet(patient,dietician,dietCreate.totalCal(), calValues.get(0), calValues.get(1), calValues.get(2));
            repository.save(diet);
        }
    }

    public Diet getDiet(long patientId){
        Patient patient = patientService.getPatientById(patientId);
        return findByPatientId(patient.getId());
    }

    public void updateCalorieIntake(UpdateDietCalorieIntake updateDiet){
        UserDetailsImpl patientUser = (UserDetailsImpl) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Patient patient = patientService.getPatientByTckn(patientUser.getUsername());
        Diet dbDiet = findByPatientId(patient.getId());
        dbDiet.setIntakeFat(dbDiet.getIntakeFat() + updateDiet.intakeFat());
        dbDiet.setIntakeProtein(dbDiet.getIntakeProtein() + updateDiet.intakeProtein());
        dbDiet.setIntakeCarbohydrate(dbDiet.getIntakeCarbohydrate() + updateDiet.intakeCarbohydrate());
        dbDiet.setIntakeCal(dbDiet.getIntakeCal() + updateDiet.intakeCal());
        repository.save(dbDiet);
    }

    private List<Double> convertTotalCaltoGramValues(long totalCal){
        List<Double> calList = new ArrayList<>();
        // Genel besin dağılımı oranları (Yüzde cinsinden)
        final double CARBOHYDRATE_RATIO = 0.5; // Karbonhidrat oranı
        final double PROTEIN_RATIO = 0.3;      // Protein oranı
        final double FAT_RATIO = 0.2;          // Yağ oranı

        // Günlük alınması gereken karbonhidrat miktarını hesapla
        double intakeCarbohydrate = totalCal * CARBOHYDRATE_RATIO / 4; // 1 gram karbonhidrat 4 kaloriye denk gelir

        // Günlük alınması gereken protein miktarını hesapla
        double intakeProtein = totalCal * PROTEIN_RATIO / 4; // 1 gram protein 4 kaloriye denk gelir

        // Günlük alınması gereken yağ miktarını hesapla
        double intakeFat = totalCal * FAT_RATIO / 9; // 1 gram yağ 9 kaloriye denk gelir
        calList.add(intakeCarbohydrate);
        calList.add(intakeFat);
        calList.add(intakeProtein);
        return calList;
    }

    public Diet findByPatientId(long patientId){
        return repository.findByPatientId(patientId).orElseThrow(() -> new DietNotFoundException("Bu hastaya ait bir diyet bilgisi bulunamadı"));
    }
}
