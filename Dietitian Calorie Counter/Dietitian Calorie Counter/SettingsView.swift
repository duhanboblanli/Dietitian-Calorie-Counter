//
//  SettingsView.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 27.07.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isDarkModeOn") var isOn = false
    @AppStorage("language") private var language = LocalizationService.shared.language
    @EnvironmentObject var navController: NavigationController
    
    let selectedMenuItem: String

    var body: some View {
        ZStack {
            Color("SideMenuBackground")
            
            VStack(alignment: .leading, spacing: 0) {
                
                // Mode Stack
                Group{
                    HStack {
                        
                        Text("mode-string".localized(language))
                            .font(.custom(FontsManager.Poppins.medium, size: 20))
                            .bold()
                            .foregroundColor(Color("textColor"))
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        
                        Toggle("", isOn: $isOn)
                            .toggleStyle(CustomToggleStyle())
                            .onChange(of: isOn) { newValue in
                                withAnimation {
                                    // dark - light mode slow animation
                                    UIApplication.shared.connectedScenes
                                        .filter({$0.activationState == .foregroundActive})
                                        .compactMap({$0 as? UIWindowScene})
                                        .first?.windows
                                        .filter({$0.isKeyWindow}).first?.rootViewController?.view.layer.add(CATransition().fadeTransition(), forKey: kCATransition)
                                    UIApplication.shared.connectedScenes
                                        .filter({$0.activationState == .foregroundActive})
                                        .compactMap({$0 as? UIWindowScene})
                                        .first?.windows
                                        .filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = newValue ? .dark : .light
                                }
                            }
                        
                    }
                    .padding(.leading,40)
                    .padding(.trailing,40)
                    
                    Rectangle()
                        .frame(height: 1)
                        .padding(.top, 15)
                        .padding(.bottom, 12)
                        .foregroundColor(Color("SideMenuSeperator"))
                        .padding(.leading,25)
                        .padding(.trailing,25)
                }
                
                Group{
                    Button(action: {
                        navController.path.append(.language)
                        
                    }) {
                        Text("language-string".localized(language))
                            .font(.custom(FontsManager.Poppins.medium, size: 20))
                            .bold()
                            .foregroundColor(Color("textColor"))
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 40)
                    }
                    
                    Rectangle()
                        .frame(height: 1)
                        .padding(.top, 18)
                        .padding(.bottom, 18)
                        .foregroundColor(Color("SideMenuSeperator"))
                        .padding(.leading,25)
                        .padding(.trailing,25)
                }
                
                Group{
                    Button(action: {
                        openAppSettings()
                    }) {
                        Text("MANAGE_PERMISSIONS".localized(language))
                            .font(.custom(FontsManager.Poppins.medium, size: 20))
                            .bold()
                            .foregroundColor(Color("textColor"))
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 40)
                    }
                    
                    Rectangle()
                        .frame(height: 1)
                        .padding(.top, 18)
                        .padding(.bottom, 18)
                        .foregroundColor(Color("SideMenuSeperator"))
                        .padding(.leading,25)
                        .padding(.trailing,25)
                }
                
                Group{
                    Button(action: {
                        EmailHelper.shared.send(subject: "Feedback", body: "", to: ["info@fogosoft.co.uk"])
                    }) {
                        Text("SEND_FEEDBACK".localized(language))
                            .font(.custom(FontsManager.Poppins.medium, size: 20))
                            .bold()
                            .foregroundColor(Color("textColor"))
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 40)
                    }
                    
                    Rectangle()
                        .frame(height: 1)
                        .padding(.top, 18)
                        .padding(.bottom, 18)
                        .foregroundColor(Color("SideMenuSeperator"))
                        .padding(.leading,25)
                        .padding(.trailing,25)
                }
                
                Group{
                    Button(action: {
                        shareApp()
                    }) {
                        Text("INVITE_FRIENDS".localized(language))
                            .font(.custom(FontsManager.Poppins.medium, size: 20))
                            .bold()
                            .foregroundColor(Color("textColor"))
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 40)
                    }

                    Rectangle()
                        .frame(height: 1)
                        .padding(.top, 18)
                        .padding(.bottom, 18)
                        .foregroundColor(Color("SideMenuSeperator"))
                        .padding(.leading,25)
                        .padding(.trailing,25)
                }
                
                Group{
                    Button(action: {
                        rateApp(id: "1579037213")
                    }) {
                        Text("RATE_US_ON_APPSTORE".localized(language))
                            .font(.custom(FontsManager.Poppins.medium, size: 20))
                            .bold()
                            .foregroundColor(Color("textColor"))
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 40)
                    }
                    
                    Rectangle()
                        .frame(height: 1)
                        .padding(.top, 18)
                        .padding(.bottom, 18)
                        .foregroundColor(Color("SideMenuSeperator"))
                        .padding(.leading,25)
                        .padding(.trailing,25)
                }
                
                Spacer()
            }// ends of VStack
            .padding(.top)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(
            title: selectedMenuItem
        ))
        // NavigationBar Color - Don't use .edgesIgnoringSafeArea() with navigationBar
        .background(Color("SideMenuBackground"))
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(selectedMenuItem: "Settings")
    }
}

// dark - light mode slow animation
extension CATransition {
    func fadeTransition() -> CATransition {
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.duration = 0.6
        return transition
    }
}

func openAppSettings() {
    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
        UIApplication.shared.open(settingsURL)
    }
}

func shareApp() {
    let textToShare = "Hey, check out this cool app!"
    
    guard let appURL = URL(string : "https://apps.apple.com/us/app/segment-ai-cut-out-objects/id1579037213") else { return }
    
    let activityViewController = UIActivityViewController(
        activityItems: [textToShare, appURL],
        applicationActivities: nil
    )
    // iPad Support
    if let popoverController = activityViewController.popoverPresentationController {
        popoverController.sourceView = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        popoverController.sourceRect = CGRect(x: 0, y: 0, width: 50, height: 50)
    }
    
    UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .compactMap({$0 as? UIWindowScene})
        .first?.windows
        .filter({$0.isKeyWindow}).first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
}

func rateApp(id : String) {
    guard let url = URL(string : "itms-apps://itunes.apple.com/app/id\(id)?mt=8&action=write-review") else { return }
    if #available(iOS 10.0, *) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    } else {
        UIApplication.shared.openURL(url)
    }
}
