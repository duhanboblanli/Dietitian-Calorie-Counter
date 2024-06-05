//
//  LoginViewModel.swift
//  SwiftClient
//
//  Created by Mohammad Azam on 4/14/21.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
    var username: String = "12345678910"
    var password: String = "Password123"
    var firstName: String = "duhan"
    var lastName: String = "boblanli"
    var errorMessage: String = ""
    @AppStorage("totalCalorie") var totalCalorie = 0.0
    @AppStorage("totalCarbs") var totalCarbs = 0.0
    @AppStorage("totalProtein") var totalProtein = 0.0
    @AppStorage("totalFat") var totalFat = 0.0
    @AppStorage("burnedInt") var burnedInt = 0
    
    // goal
    @AppStorage("goalInt") var goalInt = 0.0
    @AppStorage("goalCarbs") var goalCarbs = 0.0
    @AppStorage("goalPro") var goalPro = 0.0
    @AppStorage("goalFat") var goalFat = 0.0

    
    @Published var diet: GetDietResponse = GetDietResponse(totalCal: 0.0,
                                                              totalCarbohydrate: 0.0,
                                                              totalFat: 0.0,
                                                              totalProtein: 0.0,
                                                              intakeCarbohydrate: 0.0,
                                                              intakeFat: 0.0,
                                                           intakeProtein: 0.0, intakeCal: 0.0)

    @Published var isAuthenticated: Bool = false
    
    /*
    func login() {
        
        let defaults = UserDefaults.standard
        
        Webservice().login(username: username, password: password) { result in
            switch result {
            case .success(let token):
                defaults.setValue(token, forKey: "jsonwebtoken")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    } */
    
    func login2() {
        
        let defaults = UserDefaults.standard
        
        Webservice().login2(tckn: username, password: password) { result in
            switch result {
            case .success(let response):
                defaults.setValue(response.accessToken, forKey: "jsonwebtoken")
                defaults.setValue(response.id, forKey: "responseID")

                DispatchQueue.main.async {
                    print("Login Response:", response)
                    self.isAuthenticated = true
                    self.errorMessage = response.message ?? "No Message"
                    print("success errorMessage:",self.errorMessage)
                }
            case .failure(let error):
                switch error {
                case .custom(let errorMessage):
                    DispatchQueue.main.async {
                        self.errorMessage = errorMessage
                        print("failure errorMessage:",self.errorMessage)
                    }
                   // print("failure errorMessage:",self.errorMessage)
                case .invalidCredentials:
                    print("Invalid credentials") // Diğer hatalar için alternatif bir işlem yapabilirsiniz
                }
            }
        }
    }
    
    func register() {
        
        let defaults = UserDefaults.standard
        
        Webservice().register(firstName: firstName, lastName: lastName, tckn: username, password: password) { result in
            switch result {
            case .success(let response):
                
                defaults.setValue(response.accessToken, forKey: "jsonwebtoken")
                
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                    self.errorMessage = response.message ?? "No Message"
                    print("success errorMessage:",self.errorMessage)
                }
            case .failure(let error):
                switch error {
                case .custom(let errorMessage):
                    DispatchQueue.main.async {
                        self.errorMessage = errorMessage
                        print("failure errorMessage:",self.errorMessage)
                    }
                   // print("failure errorMessage:",self.errorMessage)
                case .invalidCredentials:
                    print("Invalid credentials") // Diğer hatalar için alternatif bir işlem yapabilirsiniz
                }
            }
        }
    }
    
    func getDiet() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        
        guard let id = defaults.string(forKey: "responseID") else {
            return
        }
        
        print("ID userDefaults: ",id)
        // "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI3MTQ0ODU0NzIxMSJ9.X05BIY0CqBTwPp4oCneRctH6ET665swJep1L7KYsFk_xxH-BbQX8IVmrMd0IflQPxSRL9yMTh-2FoBFhivlZzA"
        Webservice().getDiet(token: token, patientId: "\(id)"){ (result) in
            switch result {
                case .success(let diet):
                    DispatchQueue.main.async {
                        self.diet = diet
                        //print("getDietResponse: ", diet)
                        print("Self Diet: ", self.diet)
                        // goal
                        if let goalCal = self.diet.totalCal {
                            self.goalInt = goalCal
                        }
                        
                        if let goalCarbs = self.diet.totalCarbohydrate {
                            self.goalCarbs = goalCarbs
                        }
                        
                        if let totalFat = self.diet.totalFat {
                            self.goalFat = totalFat
                        }
                        
                        if let totalProtein = self.diet.totalProtein {
                            self.goalPro = totalProtein
                        }
                        
                        // intake
                        if let intakeCarbs = self.diet.intakeCarbohydrate {
                            self.totalCarbs = intakeCarbs
                        }
                        
                        if let intakeFat = self.diet.intakeFat {
                            self.totalFat = intakeFat
                        }
                        
                        if let intakeProtein = self.diet.intakeProtein {
                            self.totalProtein = intakeProtein
                        }
                        
                        // intakeCalorie eklenecek
                        if let intakeCalorie = self.diet.intakeCal {
                            self.totalCalorie = intakeCalorie
                        }
                        
                    }
                
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func putDiet(intakeCal:Double, intakeCarbohydrate:Double, intakeFat:Double, intakeProtein:Double  ) {
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        
        Webservice().putDiet(token: token, intakeCarbohydrate: intakeCarbohydrate, intakeFat: intakeFat, intakeProtein: intakeProtein, intakeCal: intakeCal) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    print("PUT DIET SUCCESFUL")
                }
            }
        }
    }

    
    
    func signout() {
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "jsonwebtoken")
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
        
    }
    
}
