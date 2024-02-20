//
//  AboutView.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 27.07.2023.
//

import SwiftUI
import MessageUI

struct AboutView: View {
    
    @AppStorage("language") private var language = LocalizationService.shared.language
    let selectedMenuItem: String
    
    var appVersion: String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return "version-string".localized(language) + version
        }
        return "Version: 1.0.0"
    }
    
    var body: some View {
        
        ZStack {
            Color("SideMenuBackground")
            
            //Buttons
            VStack(spacing: 10) {
                //MARK: - Privacy Policy
                Button(action: {
                   
                }) {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(height: 50)
                            .background(Color("aboutButtonColor"))
                            .cornerRadius(5)
                            .padding(.leading,20)
                            .padding(.trailing,20)
                        
                        Text("privacy-policy-string".localized(language))
                            .font(.custom(FontsManager.Poppins.medium, size: 16))
                            .foregroundColor(Color("textColor"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 35)
                    }
                    .shadow(
                        color: Color(red: 0.71, green: 0.71, blue: 0.71, opacity: 0.25), radius: 8)
                }
                
                //MARK: - Terms of Use
                Button(action: {
                  /*  RemoteConfigManager.shared.fetchRemoteConfig {
                        if let url = URL(string: RemoteConfigManager.shared.terms_conditions) {
                            UIApplication.shared.open(url) }
                    } */
                }) {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(height: 50)
                            .background(Color("aboutButtonColor"))
                            .cornerRadius(5)
                            .padding(.leading,20)
                            .padding(.trailing,20)
                        
                        Text("terms-string".localized(language))
                            .font(.custom(FontsManager.Poppins.medium, size: 16))
                            .foregroundColor(Color("textColor"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 35)
                    }
                    .shadow(
                        color: Color(red: 0.71, green: 0.71, blue: 0.71, opacity: 0.25), radius: 8)
                }
                
                //MARK: - Version
                ZStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 50)
                        .background(Color("aboutButtonColor"))
                        .cornerRadius(5)
                        .padding(.leading,20)
                        .padding(.trailing,20)
                    
                    Text(appVersion)
                        .font(.custom(FontsManager.Poppins.medium, size: 16))
                        .foregroundColor(Color("textColor"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 35)
                }
                .shadow(
                    color: Color(red: 0.71, green: 0.71, blue: 0.71, opacity: 0.25), radius: 8)
                
                
                //MARK: - Email
                Button(action: {
                    EmailHelper.shared.send(subject: "Help", body: "", to: ["info@fogosoft.co.uk"])
                }) {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(height: 50)
                            .background(Color("aboutButtonColor"))
                            .cornerRadius(5)
                            .padding(.leading,20)
                            .padding(.trailing,20)
                        
                        Text("email-string".localized(language))
                            .font(.custom(FontsManager.Poppins.medium, size: 16))
                            .foregroundColor(Color("textColor"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 35)
                    }
                    .shadow(
                        color: Color(red: 0.71, green: 0.71, blue: 0.71, opacity: 0.25), radius: 8)
                }
                //MARK: - ends of Buttons
                
                Spacer()
                // Add the FOGOSOFT Ltd. text at the bottom
                Text("ltd-string".localized(language))
                    .font(.custom(FontsManager.Poppins.medium, size: 16))
                    .foregroundColor(Color("textColor"))
                    .padding(.bottom)
            } // Ends of VStack
            .padding(.top)
        } // Ends of ZStack
        
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(title: selectedMenuItem))
        // NavigationBar Color - Don't use .edgesIgnoringSafeArea() with navigationBar
        .background(Color("SideMenuBackground"))
        
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(selectedMenuItem: "About")
    }
}


