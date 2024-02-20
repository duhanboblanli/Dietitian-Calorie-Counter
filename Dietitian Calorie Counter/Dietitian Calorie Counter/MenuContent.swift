//
//  MenuContent.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 27.07.2023.
//

import Foundation
import SwiftUI

struct MenuContent: View {
    
    @AppStorage("language") private var language = LocalizationService.shared.language
    @State private var buttonSelected: Bool = false
    @State private var destinationView: AnyView = AnyView(SettingsView(selectedMenuItem: "settings-string".localized(LocalizationService.shared.language)))
    //@AppStorage("isSubscribed") var isSubscribed = false
    @EnvironmentObject var navController: NavigationController

    var items: [MenuItem] {
        return [
            MenuItem(text: "settings-string".localized(language), imageName: "settings"),
            MenuItem(text: "subscription-plan-string".localized(language), imageName: "buy_subscribe"),
            MenuItem(text: "faq-string".localized(language), imageName: "faqs"),
            MenuItem(text: "about-string".localized(language), imageName: "about_us")
        ]
    }
    
    var body: some View {
        ZStack {
            Color("SideMenuBackground").opacity(0.92)
            
            VStack(alignment: .leading, spacing: 0) {
                
                ForEach(items) { item in
                    
                    Button(action: {
                        self.buttonSelected = true
                        
                        switch item.text {
                        case "settings-string".localized(language):
                            navController.path.append(.settings)
                        /*case "subscription-plan-string".localized(language):
                            destinationView = AnyView(storeVM.purchasedSubscriptions.isEmpty ? AnyView(SubscriptionView(viewModel: SubscriptionViewModel())) : AnyView(SubscribedUserView(viewModel: SubscriptionViewModel()))) */
                        case "subscription-plan-string".localized(language):
                            navController.path.append(.subscription)
//                            destinationView = AnyView(SubscriptionContentView())
                        case "faq-string".localized(language):
                            navController.path.append(.FAQs)
                        case "about-string".localized(language):
                            navController.path.append(.about)
                        default:
                            break
                        }
                    }) {
                        menuItemView(item: item)
                    }
                    Rectangle()
                        .frame(height: 1)
                        .padding(.top, 30)
                        .padding(.bottom, 30)
                        .foregroundColor(Color("SideMenuSeperator"))
                }
                .padding(.leading,20)
                .padding(.trailing,10)
                Spacer()
            }
            .padding(.top, 60)
        }
    }
}

extension MenuContent {
    
    func menuItemView(item: MenuItem) -> some View {
        HStack {
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32, alignment: .center)
            Text(item.text)
                .font(.custom(FontsManager.Poppins.medium, size: 20))
                .bold()
                .foregroundColor(Color("textColor"))
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
    }
}
