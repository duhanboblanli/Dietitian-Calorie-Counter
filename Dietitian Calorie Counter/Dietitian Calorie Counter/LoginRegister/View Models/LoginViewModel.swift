//
//  LoginViewModel.swift
//  SwiftClient
//
//  Created by Mohammad Azam on 4/14/21.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    var username: String = "30630654611"
    var password: String = "Password123"
    var firstName: String = "duhan"
    var lastName: String = "boblanli"
    var errorMessage: String = ""
    
    
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
    
    
    func signout() {
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "jsonwebtoken")
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
        
    }
    
}
