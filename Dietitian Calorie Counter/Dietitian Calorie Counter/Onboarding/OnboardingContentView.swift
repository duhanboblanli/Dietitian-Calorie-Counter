//
//  OnboardingContentView.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 20.09.2023.
//

import SwiftUI

private let onBoardingSteps = [
    OnBoardingStep(title: "Food Tracker: Nutrition, Calories, and Beyond".localized(LocalizationService.shared.language), description: "Communication with your dietitian while tracking your daily food intake.".localized(LocalizationService.shared.language)),
    OnBoardingStep(title: "Food Search and Detailed Food Nutrition".localized(LocalizationService.shared.language), description: "Access over 300,000 foods, search for nutrients, and add them to your daily tracker. Easily access nutritional contents of foods.".localized(LocalizationService.shared.language)),
    OnBoardingStep(title: "Stay in Touch with Your Dietitian 24/7".localized(LocalizationService.shared.language), description: "Your dietitian can track your food intake, communicate with you about them and also provide you with your daily meal plan.".localized(LocalizationService.shared.language))
]

// Gif Image
func calculateMaxHeight() -> CGFloat {
    let screenHeight = UIScreen.main.bounds.height
    // iPhone SE (1st ,3rd generation) iPhone 6, 6s, 7, 8
    if screenHeight <= 736.0 {
        return 450 * (7 / 10)
        // iPhone 12 Mini
    } else if screenHeight <= 812.0 {
        return 450 * (7.8 / 10)
        // iPhone 14 Pro
    } else if screenHeight <= 852.0 {
        return 450 * (8.6 / 10)
        // For any other devices, iPhone 14 Plus, 11 Pro Max, XS Max, iPhone X, XR, 11, 11 Pro, 14 Pro Max, 12 Pro Max
    } else {
        return 450
    }
}

// Gif Image
func calculateMaxWidth() -> CGFloat {
    let screenHeight = UIScreen.main.bounds.height
    // iPhone SE (1st ,3rd generation) iPhone 6, 6s, 7, 8
    if screenHeight <= 736.0 {
        return 220 * (7 / 10)
        // iPhone 12 Mini
    } else if screenHeight <= 812.0 {
        return 220 * (7.8 / 10)
        // iPhone 15 Pro
    } else if screenHeight <= 852.0 {
        return 220 * (8.7 / 10)
        // For any other devices, iPhone 14 Plus, 11 Pro Max, XS Max, iPhone X, XR, 11, 11 Pro, 14 Pro Max, 12 Pro Max
    } else {
        return 210
    }
}

// Gif Image
func calculateCornerRadius() -> CGFloat {
    let screenHeight = UIScreen.main.bounds.height
    // iPhone SE (1st ,3rd generation) iPhone 6, 6s, 7, 8
    if screenHeight <= 736.0 {
        return 33 * (6.5 / 10)
        // iPhone 12 Mini
    } else if screenHeight <= 812.0 {
        return 33 * (8.9 / 10)
        // iPhone 14 Pro
   /* } else if screenHeight <= 852.0 {
        return 33 */
        // For any other devices, iPhone 14 Plus, 11 Pro Max, XS Max, iPhone X, XR, 11, 11 Pro, 14 Pro Max, 12 Pro Max
    } else {
        return 33
    }
}

struct OnboardingContentView: View {
    
    @State private var currentStep = 0
    @State private var startButtonPressed: Bool = false
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var navController: NavigationController
    @AppStorage("language") private var language = LocalizationService.shared.language
    @AppStorage("isOnboarding") var isOnboarding = true

    
    init() {
        UIScrollView.appearance().bounces = false
    }
    var body: some View {
        
        ZStack {
            Color("SideMenuBackground")
            // Background Swipe Animation
            GeometryReader { geometry in
                Image("onBoarding")
                    .scaledToFill()
                    .frame(width: geometry.size.width + 800)
                // iPhone 8 height 667
                    .frame(height: UIScreen.main.bounds.height == 667.0 ? 390 : 500)
                    .offset(x: CGFloat(currentStep) * -geometry.size.width)
                // iPhone 8 height 667
                    .offset(y: UIScreen.main.bounds.height == 667.0 ? -84.0 : -56.0)
            }
            VStack {
                
                //MARK: - Skip Button
                HStack{
                    Spacer()
                    Button(action: {
                        // For last onboardingScreen
                        //self.currentStep = onBoardingSteps.count - 1
                        
                        isOnboarding = false
                        print("isOnboarding:",isOnboarding)

                        
                        // For jump to subscription screen
                        navController.path.append(NavigationScreen.subscription)
                        
                    }) {
                        Text("skip-button-string".localized(LocalizationService.shared.language))
                            .padding(.horizontal,16)
                        //.padding(.top)
                            .foregroundColor(.gray)
                    }
                }
                
                // Gif Image
                LottieView(name: "new.json")
                    .cornerRadius(calculateCornerRadius())
                    .frame(maxWidth: calculateMaxWidth())
                    .frame(maxHeight: calculateMaxHeight())
                    .scaledToFill()
                    .padding(.top,-16)
                
                //MARK: - TabView
                TabView(selection: $currentStep){
                    ForEach(0..<onBoardingSteps.count, id: \.self) { it in
                        VStack {
                            //Linear Gradient Title
                            Text(onBoardingSteps[it].title)
                                .font(.custom(FontsManager.Poppins.semi_bold, size: 34))      .foregroundStyle(LinearGradient(
                                    colors: [Color("OnboardingPink"), Color("OnboardingBlue")],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .frame(maxWidth: .infinity, maxHeight: 120, alignment: .center)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal,32)

                            // Description
                            Text(onBoardingSteps[it].description)
                                .font(.custom(FontsManager.Poppins.light, size: 16))
                                .multilineTextAlignment(.center)
                                .frame(maxHeight: 60, alignment: .center)
                                .padding(.horizontal,48)
                                   
                        } // ends of VStack
                        .minimumScaleFactor(0.1)
                        .tag(it)
                        .gesture(DragGesture().onEnded { gesture in
                            if gesture.translation.width < 0 && currentStep != onBoardingSteps.count - 1  { // Left swipe
                                withAnimation {
                                    currentStep += 1
                                }
                            } else if gesture.translation.width > 0 && currentStep > 0 { // Right swipe
                                withAnimation {
                                    currentStep -= 1
                                }
                            }
                        })
                    }
                }// ends of tabView
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                //MARK: - TabView Circles
                HStack {
                    ForEach(0..<onBoardingSteps.count, id: \.self) { it in
                        if it == currentStep {
                            Rectangle()
                                .frame(width: 10,height: 10)
                                .cornerRadius(10)
                                .foregroundColor(SamColors.ellipseColor)

                        } else {
                            Circle()
                                .frame(width: 10,height: 10)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.bottom,11)
                .padding(.top,11)
                
                //MARK: - Start Button
                if self.currentStep == onBoardingSteps.count - 1 {
                    Button(action: {
                        navController.path.append(NavigationScreen.subscription)
                        isOnboarding = false

                    }){
                        Text("start-button-string".localized(LocalizationService.shared.language))
                            .font(.custom(FontsManager.Poppins.medium, size: 20))
                            .minimumScaleFactor(0.5)
                            .foregroundColor(.white)
                            .frame(width: 200,height: 40)
                            .background{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(SamColors.tapToAICutGradient)
                                    .shadow(color: .white.opacity(0.25), radius: 5, x: 0, y: 0)
                                    .shadow(color: Color(red: 0.38, green: 0.38, blue: 0.38).opacity(0.25), radius: 2.5, x: 0, y: 2)
                                
                            }
                            .shadow(color: .white.opacity(0.25), radius: 5, x: 0, y: 0)
                            .shadow(color: Color(red: 0.38, green: 0.38, blue: 0.38).opacity(0.25), radius: 2.5, x: 0, y: 2)
                    }
                    .padding(.bottom, 30)
                    
                    //MARK: - Next Button
                } else {
                    Button(action: {
                        withAnimation {
                            self.currentStep += 1
                        }
                    }) {
                        Text("next-button-string".localized(LocalizationService.shared.language))
                            .font(.custom(FontsManager.Poppins.medium, size: 20))
                            .minimumScaleFactor(0.5)
                            .foregroundColor(.white)
                            .frame(width: 200,height : 40)
                            .background{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(SamColors.tapToAICutGradient)
                                    .shadow(color: .white.opacity(0.25), radius: 5, x: 0, y: 0)
                                    .shadow(color: Color(red: 0.38, green: 0.38, blue: 0.38).opacity(0.25), radius: 2.5, x: 0, y: 2)
                            }
                    }
                    .padding(.bottom, 30)
                }
            } // ends of VStack
        } // ends of ZStack
        // NavigationStack Background Color
        .background(Color("SideMenuBackground"))
        // ends of NavigationStack
        .gesture(DragGesture().onEnded { gesture in
            if gesture.translation.width < 0 && currentStep != onBoardingSteps.count - 1  { // Left swipe
                withAnimation {
                    currentStep += 1
                }
            } else if gesture.translation.width > 0 && currentStep > 0 { // Right swipe
                withAnimation {
                    currentStep -= 1
                }
            }
        })
        .navigationBarBackButtonHidden(true)
    }
}

struct OnboardingContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingContentView()
    }
}


