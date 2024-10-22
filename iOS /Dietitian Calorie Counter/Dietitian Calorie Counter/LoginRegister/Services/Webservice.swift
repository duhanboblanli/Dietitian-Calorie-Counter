import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case encodingError
}

//MARK: - Register
struct RegisterRequestBody: Codable {
    let firstName: String
    let lastName: String
    let tckn: String
    let password: String
}

struct RegisterResponse: Codable {
    let message: String?
    let accessToken: String?
    let id: Int?
}

//MARK: - Login
struct LoginRequestBody2: Codable {
    let tckn: String
    let password: String
}

struct LoginResponse2: Codable {
    let message: String?
    let accessToken: String?
    let id: Int?
}

//MARK: - Get Diet
struct GetDietResponse: Codable {
    let totalCal: Double?
    let totalCarbohydrate: Double?
    let totalFat: Double?
    let totalProtein: Double?
    
    let intakeCarbohydrate: Double?
    let intakeFat: Double?
    let intakeProtein: Double?
    let intakeCal: Double?
}

//MARK: - Put Diet
struct PutDietRequest: Codable {
    let intakeCarbohydrate: Double?
    let intakeFat: Double?
    let intakeProtein: Double?
    let intakeCal: Double?
}

class Webservice {
    
    //MARK: - Login
    func login2(tckn: String, password: String, completion: @escaping (Result<LoginResponse2, AuthenticationError>) -> Void) {
        
        print("LOGIN2 START, tckn: ",tckn, "password: ",password)
        
        /*
         guard let url = URL(string: "http://localhost:8080/api/v1/login") else {
         completion(.failure(.custom(errorMessage: "URL is not correct")))
         return
         }*/
        
        guard let url = URL(string: "https://dieticianpatientapp.onrender.com/api/v1/login") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        //let body = LoginRequestBody2(tckn: "30630654611", password: "Password123")
        let body = LoginRequestBody2(tckn: tckn, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            do {
                let loginResponse = try JSONDecoder().decode(LoginResponse2.self, from: data)
                
                print("loginResponse:",loginResponse)
                
                if let token = loginResponse.accessToken {
                    completion(.success(loginResponse))
                } else {
                    //completion(.failure(.invalidCredentials))
                    let errorMessage = loginResponse.message ?? "Decoding error"
                    
                    completion(.failure(.custom(errorMessage: errorMessage)))
                    //print("errorMessage:",errorMessage)
                }
            } catch {
                
                completion(.failure(.custom(errorMessage: "Decoding error")))
                
            }
            
        }.resume()
        
        
        
        
    }
    
    
    //MARK: - Register
    func register(firstName: String, lastName: String, tckn: String, password: String, completion: @escaping (Result<RegisterResponse, AuthenticationError>) -> Void) {
        
        print("REGISTER START, tckn: ",tckn, "password: ",password, "firstName: ",firstName,"lastName: ",lastName)
        
        /*
         guard let url = URL(string: "http://localhost:8080/api/v1/register/patient") else {
         completion(.failure(.custom(errorMessage: "URL is not correct")))
         return
         } */
        
        guard let url = URL(string: "https://dieticianpatientapp.onrender.com/api/v1/register/patient") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
         
        //let body = LoginRequestBody2(tckn: "30630654611", password: "Password123")
        //let body = LoginRequestBody2(tckn: tckn, password: password)
        
        let body = RegisterRequestBody(firstName: firstName, lastName: lastName, tckn: tckn, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            do {
                let registerResponse = try JSONDecoder().decode(RegisterResponse.self, from: data)
                
                print("registerResponse:",registerResponse)
                
                if let token = registerResponse.accessToken {
                    completion(.success(registerResponse))
                } else {
                    //completion(.failure(.invalidCredentials))
                    let errorMessage = registerResponse.message ?? "No Auth Error"
                    
                    completion(.failure(.custom(errorMessage: errorMessage)))
                    //print("errorMessage:",errorMessage)
                }
            } catch {
                
                completion(.failure(.custom(errorMessage: "Decoding error")))
                
            }
            
        }.resume()
    }
    
    func putDiet(token: String, intakeCarbohydrate: Double, intakeFat: Double, intakeProtein: Double, intakeCal: Double, completion: @escaping (NetworkError?) -> Void) {
        
        guard let url = URL(string: "https://dieticianpatientapp.onrender.com/api/v1/diet") else {
            completion(.invalidURL)
            return
        }
        
        let body = PutDietRequest(intakeCarbohydrate: intakeCarbohydrate, intakeFat: intakeFat, intakeProtein: intakeProtein, intakeCal: intakeCal)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            completion(.encodingError)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let _ = data, error == nil else {
                completion(.noData)
                return
            }
            
            completion(nil)
        }.resume()
    }


    
    //MARK: - get diet
    func getDiet(token: String,patientId: String, completion: @escaping (Result<GetDietResponse, NetworkError>) -> Void) {
        
        guard let url = URL(string: "https://dieticianpatientapp.onrender.com/api/v1/diet?patientId=\(patientId)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
       // request.addValue(patientId, forHTTPHeaderField: "patientId")
        
        print("getDietURL: ", request)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            guard let diet = try? JSONDecoder().decode(GetDietResponse.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(diet))
        }.resume()
    }// ends of getAllAccounts
    
    //MARK: - get request example
    func getAllAccounts(token: String, completion: @escaping (Result<[Account], NetworkError>) -> Void) {
        
        guard let url = URL(string: "https://strong-spangled-apartment.glitch.me/accounts") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            guard let accounts = try? JSONDecoder().decode([Account].self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(accounts))
        }.resume()
    }// ends of getAllAccounts
    
    
    
}
