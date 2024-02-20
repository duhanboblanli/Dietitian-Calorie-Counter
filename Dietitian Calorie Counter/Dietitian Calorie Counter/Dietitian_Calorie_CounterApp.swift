//
//  Dietitian_Calorie_CounterApp.swift
//  Dietitian Calorie Counter
//
//  Created by Duhan Boblanlı on 20.02.2024.
//

import SwiftUI

@main
struct Dietitian_Calorie_CounterApp: App {
    
    @AppStorage("isDarkModeOn") var isOn = false
    @AppStorage("isOnboarding") var isOnboarding = true
    @AppStorage("language") private var language = LocalizationService.shared.language
    @ObservedObject var navigationController = NavigationController.shared
    
    init() {
        print("isOnboarding:",isOnboarding)
        if isOnboarding {
            navigationController.path.append(NavigationScreen.onboarding)
        }
    }
    
    
    var body: some Scene {
        WindowGroup {
            
            /*
            PhotoEditView(image: UIImage(named: "png-example")!)
                .environmentObject(PECtl.shared)
                .environmentObject(PhotoEditorData.shared)
                .preferredColorScheme(.dark)
           */
        
            
         NavigationStack(path: $navigationController.path){
                MainView()
                    .environmentObject(navigationController)
                    //.environmentObject(aiCutViewModel)
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
                            MainView()
                                .environmentObject(navigationController)
                                //.environmentObject(aiCutViewModel)
                                .preferredColorScheme(isOn ? .dark : .light)
                            
                            
                        case .aicut:
                            HomeView()
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
                        } // ends of switch-case
                    }
            } // ends of NStack
            
            
        }
    }
}
