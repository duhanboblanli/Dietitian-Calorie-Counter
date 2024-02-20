//
//  SubscriptionNavigationButton.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 2.09.2023.
//

import SwiftUI

struct SubscriptionNavigationButton: View {
    
    @EnvironmentObject var viewModel: MainViewModel
    @EnvironmentObject var navController: NavigationController
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("language") private var language = LocalizationService.shared.language
    @AppStorage("remainingCoin") var remainingCoin: Int = 0
    @AppStorage("selectedPlan") private var selectedPlan = ""
    
    // Set text size with poppins font
    
    func textSize() -> CGFloat {
        return 18
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            Button(action: {
                navController.path.append(.subscription)
            }) {
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: geometry.size.width , height: 100)
                        .background(
                            Image("subsNavigationBackground")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: 100)
                        )
                        .cornerRadius(15)
                        .shadow(
                            color: Color(red: 0.87, green: 0.87, blue: 0.87, opacity: 0.25),
                            radius: 10
                        )
                    
                    HStack {
                        
                        Image("Diyetisyen")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding(.top, 10)
                            .padding(.bottom, 45)
                        
                        Spacer().frame(width: 16)
                        
                        Text("Dyt. Mehtap Yakut")
                            .font(.custom(FontsManager.Poppins.medium, size: textSize() + 2 ))
                            .foregroundColor(colorScheme == .dark ? Color(red: 0.09, green: 0.11, blue: 0.21) : Color(red: 0.96, green: 0.96, blue: 0.96))
                            .lineLimit(1)
                            .padding(.top, 23)
                            .padding(.bottom, 56)
                            .minimumScaleFactor(0.5)
                        
                        Spacer().frame(width: 30)
                        
                        Image(systemName: "message")
                            .resizable()
                            .frame(width: 19,height: 19)
                            .scaledToFit()
                            .padding(.top, 22)
                            .padding(.bottom, 57)
                            .scaledToFit()
                            .foregroundColor(colorScheme == .dark ? Color(red: 0.09, green: 0.11, blue: 0.21) : Color(red: 0.96, green: 0.96, blue: 0.96))
                        
                        
                         HStack {
                        /* Text(String(remainingCoin))
                         .font(.custom(FontsManager.HagiaPro.extrabold, size: textSize() * 2 ))
                         .foregroundColor(colorScheme == .dark ? Color(red: 0.09, green: 0.11, blue: 0.21) : Color(red: 0.96, green: 0.96, blue: 0.96))
                         .lineLimit(1)
                         .padding(.top, 16)
                         .padding(.bottom, 63)
                         
                         LottieView(name: "coin-lottie.json")
                         .frame(width: 52, height: 52)
                         .padding(.top, 3)
                         .padding(.bottom, 54) */
                             
                             
                                 
                         }
                        Spacer()
                    }
                    .padding(.leading , 35)
                    .padding(.trailing, 10)
                    
                        // Text Linear Gradient Bold
                        LinearGradient(
                            gradient: Gradient(colors: [Color("subsPinkGradient"), Color("subsBlueGradient")]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .mask(Text("Murat Bey selam! Ben danışmanınız Mehtap. Günlük planınızı iletiyorum. Sorularınız olursa ulaşabilirsiniz..".localized(language))
                            .font(.custom(FontsManager.Poppins.bold, size: textSize() - 4))
                            .multilineTextAlignment(.leading)
                        )
                        .frame(maxWidth: .infinity, alignment: .center)
                        //.minimumScaleFactor(0.5)
                        .lineLimit(2)
                        .padding(.horizontal, 22)
                        .padding(.top, 55)
                        .padding(.bottom, 9)
                        
                  
                    
                }
                .onAppear{
                }
            }
        }
    }
}

struct SubscriptionNavigationButton_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}





