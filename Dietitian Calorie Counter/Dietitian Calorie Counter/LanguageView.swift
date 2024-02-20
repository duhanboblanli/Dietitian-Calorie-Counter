import SwiftUI

struct LanguageView: View {
    
    @AppStorage("language") private var language = LocalizationService.shared.language
    
    @State private var selectedLanguageIndex = 0
    
    // Available language options
    var languages: [String] {
        return [
            "eng-string".localized(language),
            "spn-string".localized(language),
            "ger-string".localized(language),
            "fr-string".localized(language),
            "it-string".localized(language),
            "rus-string".localized(language),
            "tr-string".localized(language),
            "jap-string".localized(language),
            "zh-hans-string".localized(language),
        ]
    }
 
    var body: some View {
  
        ZStack {
            Color("SideMenuBackground")
            VStack() {
                
                ForEach(languages.indices, id: \.self) { index in
                    
                    let language = languages[index]
                    let isSelected = selectedLanguageIndex == index
                    
                    Button(action: {
                        
                        if isSelected {
                            return // Do nothing if it's already selected
                        }
                        
                        // Update Index
                        if selectedLanguageIndex != index {
                            selectedLanguageIndex = index
                            UserDefaults.standard.set(index, forKey: "selectedLanguageIndex")
                        }
                        
                        // Update language
                        if selectedLanguageIndex == index {
                            switch index {
                            case 0:
                                LocalizationService.shared.language = .english
                            case 1:
                                LocalizationService.shared.language = .spanish
                            case 2:
                                LocalizationService.shared.language = .german
                            case 3:
                                LocalizationService.shared.language = .french
                            case 4:
                                LocalizationService.shared.language = .italian
                            case 5:
                                LocalizationService.shared.language = .russian
                            case 6:
                                LocalizationService.shared.language = .turkish
                            case 7:
                                LocalizationService.shared.language = .japanese
                            case 8:
                                LocalizationService.shared.language = .simplifiedChinese
                            default:
                                break
                            }
                        }
                        
                    }) {
                        HStack {
                            ZStack {
                                Circle()
                                    .stroke(Color("languageButtonColor")) // Border color
                                    .frame(width: 20, height: 20)
                                
                                if isSelected {
                                    Circle()
                                        .fill(Color("languageButtonColor")) // Selected circle color
                                        .frame(width: 20, height: 20)
                                }
                                
                            }
                            .padding(.trailing, 25)
                            Text(language)
                                .foregroundColor(Color("textColor"))
                                .font(.custom(FontsManager.Poppins.medium, size: 16))
                            
                            Spacer()
                        }
                        .padding(.leading, 45)
                    }
                    .padding(.bottom, 12)
                }
                
                Spacer()
            }
            .padding(.top)
            .navigationBarBackButtonHidden(true) // Hide the default back button
            .navigationBarItems(leading: languageBackButton(title: "language-string".localized(language))) // Add a custom back button
            // NavigationBar Color - Don't use .edgesIgnoringSafeArea() with navigationBar
            .background(Color("SideMenuBackground"))
        }
        .onAppear {
            if let savedIndex = UserDefaults.standard.value(forKey: "selectedLanguageIndex") as? Int {
                selectedLanguageIndex = savedIndex
            }
        }
        
        .onDisappear {
            @AppStorage("language") var language = LocalizationService.shared.language

        }

    }
}

struct languageBackButton: View {
    
    let title: String
    @State private var languageBackButtonPressed: Bool = false
    @EnvironmentObject var navController: NavigationController
    
    var body: some View {
        Button(action: {
            navController.path.removeLast()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Spacer().frame(width: 12) // Add 12 points of spacing between the Image and Text
                Text(title)
            }
            .foregroundColor(Color("navigationBarTitle"))
        }

        
    }
}

