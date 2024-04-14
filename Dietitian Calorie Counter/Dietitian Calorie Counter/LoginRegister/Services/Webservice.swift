import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

struct LoginRequestBody: Codable {
    let username: String
    let password: String
}

struct LoginResponse: Codable {
    let token: String?
    let message: String?
    let success: Bool?
}

struct LoginRequestBody2: Codable {
    let tckn: String
    let password: String
}

struct LoginResponse2: Codable {
    let message: String?
    let accessToken: String?
    let id: Int?
}


class Webservice {
    
    func login2(tckn: String, password: String, completion: @escaping (Result<LoginResponse2, AuthenticationError>) -> Void) {
        
        print("LOGIN2 START, tckn: ",tckn, "password: ",password)
        
        guard let url = URL(string: "http://localhost:8080/api/v1/login") else {
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
    
    // Header Token:
    //Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImpvaG5kb2UiLCJpYXQiOjE3MTI2MDI1NjZ9.R0F_ElZuXUMEG_qqcJQOYHv4stphKgIzj887ykJviCU
    
    // Return:
    /*
     [
     {
     "name": "johndoe",
     "balance": 5000
     },
     {
     "name": "johndoe",
     "balance": 2500
     }
     ]
     */
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
        
        
    }
    
    // POST: username and password
    // Return: Generated Token
    //{"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImpvaG5kb2UiLCJpYXQiOjE3MTI2MDI1NjZ9.R0F_ElZuXUMEG_qqcJQOYHv4stphKgIzj887ykJviCU"}
    func login(username: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
        guard let url = URL(string: "https://strong-spangled-apartment.glitch.me/login") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = LoginRequestBody(username: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            try! JSONDecoder().decode(LoginResponse.self, from: data)
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            print("LOGIN1 DATA:",loginResponse)
            
            guard let token = loginResponse.token else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let errorMessage = loginResponse.message else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            completion(.success(token))
            
        }.resume()
        
        
        
        
    }
}
