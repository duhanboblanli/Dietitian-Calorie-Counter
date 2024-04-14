//
//  WelcomeView.swift
//  SwiftClient
//
//  Created by Duhan Boblanlı on 8.04.2024.
//

import SwiftUI

struct LoginRegisterView: View {
    
    @StateObject private var loginVM = LoginViewModel()
    @StateObject private var accountListVM = AccountListViewModel()
    
    @State var confirmationPassword: String
    @State var registerMode: Bool = false
    @State private var errorMessage: String = ""
    @EnvironmentObject var navController: NavigationController


    var body: some View {
        ZStack {
            StaticBackground()

            VStack {
                HStack {
                    Text(loginVM.isAuthenticated ? "Token authenticated" : "Token not authenticated")
                    Image(systemName: loginVM.isAuthenticated ? "lock.fill": "lock.open")
                }
               
                VStack(spacing: 10) {
                    Spacer().frame(height: 10)
                    if registerMode {
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                                .foregroundColor(Color(#colorLiteral(red: 0.3544496118, green: 0.3544496118, blue: 0.3544496118, alpha: 1)))
                                .frame(width: 44, height: 44)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                .shadow(color: Color(#colorLiteral(red: 0.1647058824, green: 0.1882352941, blue: 0.3882352941, alpha: 1)).opacity(0.1), radius: 5, x: 0, y: 5)
                                .padding(.leading)
                            
                            
                            TextField("First Name".uppercased(), text: $loginVM.firstName)
                              
                                //.keyboardType(.default)
                                //.font(.subheadline)
                                .padding(.leading)
                                .frame(height: 44)
                            
                            Divider().frame(height: 20)
                            TextField("Last Name".uppercased(), text: $loginVM.lastName)
                              
                                //.keyboardType(.default)
                                //.font(.subheadline)
                                .padding(.leading)
                                .frame(height: 44)

                            
                        }
                    }
                    HStack {
                        Image(systemName: "person.text.rectangle.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.3544496118, green: 0.3544496118, blue: 0.3544496118, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color(#colorLiteral(red: 0.1647058824, green: 0.1882352941, blue: 0.3882352941, alpha: 1)).opacity(0.1), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        
                        
                        //TextField("Identity Number".uppercased(), text: $loginVM.username)
                        TextField("Identity Number".uppercased(), text: $loginVM.username)
                            //.keyboardType(.default)
                            //.font(.subheadline)
                            .padding(.leading)
                            .frame(height: 44)
                        
                    }
                    Divider().padding(.leading, 80)
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.3544496118, green: 0.3544496118, blue: 0.3544496118, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color(#colorLiteral(red: 0.1647058824, green: 0.1882352941, blue: 0.3882352941, alpha: 1)).opacity(0.1), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        
                        SecureField("Password".uppercased(), text: $loginVM.password) {
                            if !registerMode {
                                loginVM.login2()
                            }
                        }
                    
                        .padding(.leading)
                        .frame(height: 44)
                        
                    }
                    
                    if registerMode {
                        Divider().padding(.leading, 80)
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(Color(#colorLiteral(red: 0.3544496118, green: 0.3544496118, blue: 0.3544496118, alpha: 1)))
                                .frame(width: 44, height: 44)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                .shadow(color: Color(#colorLiteral(red: 0.1647058824, green: 0.1882352941, blue: 0.3882352941, alpha: 1)).opacity(0.1), radius: 5, x: 0, y: 5)
                                .padding(.leading)
                            
                            SecureField("repeat password".uppercased(), text: $confirmationPassword) {
                                // Register
                                loginVM.login2()
                            }
                           
                            .keyboardType(.default)
                            .font(.subheadline)
                            .padding(.leading)
                            .frame(height: 44)
                        }
                    }
                    Spacer().frame(height: 10)
                }
                .frame(height: registerMode ? .infinity : 136)
                .frame(maxWidth: .infinity)
                .background(Color(#colorLiteral(red: 0.974566576, green: 0.974566576, blue: 0.974566576, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color(#colorLiteral(red: 0.1647058824, green: 0.1882352941, blue: 0.3882352941, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 20)
                .padding(.horizontal, 16)
                
                Spacer().frame(height: 10)

                //MARK: - REGISTER
                HStack {
                    Button(action: {
                        if registerMode {
                            if loginVM.password == confirmationPassword {
                                if (loginVM.password != "") && (confirmationPassword != "") {
                                    //register()
                                    //loginVM.login2()
                                    print("Register Clicked")
                                } else {
                                    if loginVM.username != "" {
                                        print("Please enter a password")
                                        errorMessage = "Please enter a password"
                                    } else {
                                        print("Please enter a password or username")
                                        errorMessage = "Please enter a password or username"
                                    }
                                }
                            } else {
                                print("Passwords don't match")
                                errorMessage = "Passwords don't match"

                            }
                        } else {
                            withAnimation() {
                                registerMode = true
                            }
                        }
                        
                    }) {
                        Text("Register")
                            .fontWeight(.semibold)
                            .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                            .frame(width: 120, height: 50, alignment: .center)
                            .background(Color(#colorLiteral(red: 0.974566576, green: 0.974566576, blue: 0.974566576, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .circular))
                            .shadow(color: Color(#colorLiteral(red: 0.1647058824, green: 0.1882352941, blue: 0.3882352941, alpha: 1)).opacity(0.2), radius: 5, x: 0, y: 5)
                            .padding(.horizontal, 16)
                    }
                    Spacer()
                    
                    //MARK: - LOGIN
                    Button(action: {
                        if registerMode {
                            withAnimation() {
                                registerMode = false
                            }
                        } else {
                            //login()
                            if (loginVM.password == "") {
                                if loginVM.username == "" {
                                    print("Please enter a password or username")
                                    errorMessage = "Please enter a password or username"
                                }
                                else {
                                    print("Please enter a password")
                                    errorMessage = "Please enter a password"
                               }
                            } else {
                                loginVM.login2()
                                    //errorMessage = loginVM.isAuthenticated ? "" : "Login failed!"
                                errorMessage = loginVM.errorMessage
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    errorMessage = loginVM.errorMessage

                                    if loginVM.isAuthenticated {
                                        //navController.path.removeAll()
                                        navController.path.append(NavigationScreen.main)

                                    }
                                }
                                //navController.path.removeAll()
                            }
                        }
                    }) {
                        Text("Login")
                            .fontWeight(.semibold)
                            .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                            .frame(width: 120, height: 50, alignment: .center)
                            .background(Color(#colorLiteral(red: 0.974566576, green: 0.974566576, blue: 0.974566576, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .circular))
                            .shadow(color: Color(#colorLiteral(red: 0.1647058824, green: 0.1882352941, blue: 0.3882352941, alpha: 1)).opacity(0.2), radius: 5, x: 0, y: 5)
                            .padding(.horizontal, 16)
                    }
                }
                Spacer().frame(height: 20)

                if !errorMessage.isEmpty {
                    if loginVM.isAuthenticated {
                        Text("Login Succesful!")
                            .foregroundColor(loginVM.isAuthenticated ? .green : .red)
                            .padding()
                    } else {
                            Text(errorMessage)
                                .foregroundColor(loginVM.isAuthenticated ? .green : .red)
                                .padding()
                    }
                }
                
                Spacer().frame(height: 20)
                VStack {
                    
                    if loginVM.isAuthenticated && accountListVM.accounts.count > 0 {
                        List(accountListVM.accounts, id: \.id) { account in
                            HStack {
                                Text("\(account.name)")
                                Spacer()
                                Text(String(format: "$%.2f", account.balance))
                            }
                        }.listStyle(PlainListStyle())
                    } 
                    if loginVM.isAuthenticated {
                        Text("Logged in!")
                        
                        Button("Get Accounts") {
                            accountListVM.getAllAccounts()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                        
                        Button("Signout") {
                            loginVM.signout()
                            accountListVM.accounts.removeAll()
                            errorMessage = ""
                        }
                    }
                    else {
                        Text("Login to see your accounts!")
                    }
                    
                    
                }.frame(maxWidth: .infinity, maxHeight: 200)

                
                
            }
           // .offset(y: (isFocused && registerMode) ? -29 : 0).animation(.easeInOut)
            
            
        }
    }
    
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct LoginRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        LoginRegisterView(confirmationPassword: "")
    }
}

struct Background<Content: View>: View {
    private var content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        Color.white
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .overlay(content)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
