//
//  Dietitian_Calorie_CounterApp.swift
//  Dietitian Calorie Counter
//
//  Created by Duhan Boblanlı on 20.02.2024.
//

import SwiftUI
import Firebase


@main
struct Dietitian_Calorie_CounterApp: App {
    
    @AppStorage("isDarkModeOn") var isOn = false
    @AppStorage("isOnboarding") var isOnboarding = true
    @AppStorage("language") private var language = LocalizationService.shared.language
    @ObservedObject var navigationController = NavigationController.shared
    @ObservedObject var loginVM = LoginViewModel()

    
    init() {
        FirebaseApp.configure()

        print("isOnboarding:",isOnboarding)
        if isOnboarding {
            navigationController.path.append(NavigationScreen.onboarding)
        } else {
            navigationController.path.append(NavigationScreen.subscription)
        }

    }
    
    
    var body: some Scene {
        WindowGroup {
            
         NavigationStack(path: $navigationController.path){
                MainView()
                    .environmentObject(navigationController)
                    .environmentObject(loginVM)
                    .preferredColorScheme(isOn ? .dark : .light)
             
                    .navigationDestination(for: NavigationScreen.self){ screen in
                        
                        switch screen{
                        case .onboarding:
                            OnboardingContentView()
                                .environmentObject(navigationController)
                                .preferredColorScheme(isOn ? .dark : .light)
                                .onAppear {
                                    print("Onboarding Working")
                                }
                            
                        case .subscription:
                            LoginRegisterView(confirmationPassword: "")
                                .navigationBarHidden(true)
                                .environmentObject(navigationController)
                                .environmentObject(loginVM)
                                .preferredColorScheme(isOn ? .dark : .light)
                               
                        case .aicut:
                            ListView()
                                .preferredColorScheme(isOn ? .dark : .light)

                        case .settings:
                            SettingsView(selectedMenuItem: "settings-string".localized(LocalizationService.shared.language))
                                .environmentObject(navigationController)
                        case .FAQs:
                            FAQView(selectedMenuItem: "faq-string".localized(language))
                                .environmentObject(navigationController)
                        case .about:
                            AboutView(selectedMenuItem: "about-string".localized(language))
                                .environmentObject(navigationController)
                        case .language:
                            LanguageView()
                                .environmentObject(navigationController)
                        case .main:
                            MainView()
                                .environmentObject(navigationController)
                                //.environmentObject(aiCutViewModel)
                                .preferredColorScheme(isOn ? .dark : .light)

                        case .chat:
                            ChatView()
                        } // ends of switch-case
                    }
            } // ends of NStack
            
            
        }
    }
}
