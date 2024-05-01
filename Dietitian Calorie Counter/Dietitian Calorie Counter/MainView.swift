//
//  MainView.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 6.07.2023.
//
import SwiftUI
import PhotosUI

struct MainView: View {
    
    // View Models
    @StateObject var viewModel: MainViewModel = MainViewModel()
    @EnvironmentObject var navController: NavigationController
    @EnvironmentObject var loginVM : LoginViewModel
    @AppStorage("isOnboarding") var isOnboarding = false

    @State var centerY: CGFloat = 0
    @State var menuOpened = false
    @State private var cur_tag = 0
    
    // intake
    @AppStorage("totalCalorie") var totalCalorie = 0.0
    @AppStorage("totalCarbs") var totalCarbs = 0.0
    @AppStorage("totalProtein") var totalProtein = 0.0
    @AppStorage("totalFat") var totalFat = 0.0
    
    // goal
    @AppStorage("goalInt") var goalInt = 2000.0
    @AppStorage("goalCarbs") var goalCarbs = 0.0
    @AppStorage("goalPro") var goalPro = 0.0
    @AppStorage("goalFat") var goalFat = 0.0
    
    // local
    @State private var intakeCalorie: Double = 0
    @State private var burnedInt1: Int = 0
    @State private var goalInt1: Double = 0
    @State private var goalRatio: Double = 0
    @State private var totalCarbs1: Double = 0
    @State private var totalProtein1: Double = 0
    @State private var totalFat1: Double = 0
    
    @State private var goalCarbs1: Double = 0
    @State private var goalPro1: Double = 0
    @State private var goalFat1: Double = 0
    
    // dummy
    @AppStorage("burnedInt") var burnedInt = 0


    init() {
        UITabBar.appearance().isHidden = true
       // loginVM.getDiet()
    }
    
    var body: some View {
        
        VStack(spacing: 0.0) {
            mainView
                //.environmentObject(loginVM)
            // Custom TabBar
            CustomTabBar(centerY: $centerY)
            
            // For smaller size iPhone padding will be 25 and for notch phones no padding
            // iPhone 8 --> bottom padding 25
            // iPhone 14 --> no padding
                .padding(.bottom, UIApplication
                    .shared
                    .connectedScenes
                    .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                    .first { $0.isKeyWindow }?.safeAreaInsets.bottom == 0 ? 25 : UIApplication
                    .shared
                    .connectedScenes
                    .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                    .first { $0.isKeyWindow }?.safeAreaInsets.bottom)
            
            // Animated Circle Color
                .background(Color.white.opacity(0.4).clipShape(AnimatedShape(centerX: UIScreen.main.bounds.midX, centerY: centerY)))
                .shadow(color: Color.black.opacity(0.1), radius: 17, x: 0, y: -5)
            
        } // ends of VStack
        .ignoresSafeArea(.all, edges: .bottom)
        .environmentObject(viewModel)
        
    }
    var mainView: some View {
        
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            
            StaticBackground()
            //AnimatedBackground()
            
            // General Vertical Stack View
            VStack {
                
                // Title View + SideMenu Button
                HStack {
                    // TitleView (Rectangle + Title View)
                    TitleView()
                    Spacer()
                    
                    // Side Menu Button
                    if !menuOpened {
                        Button(action: {
                            self.menuOpened.toggle()
                        }, label: {
                            Image("sideMenuButton")
                                .resizable()
                                .frame(width: 36, height: 36)
                        })
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, 25)
                .padding(.top,60)
                
                // Subs Button
                SubscriptionNavigationButton()
                    .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
                    .padding(.top,20)
                    .padding(.horizontal, 25)
                    .padding(.bottom, 20)
                                
                DailyOverView(intake: $intakeCalorie, caloriesBurned: $burnedInt1, goalSetToday: $goalInt1, goalCarbs: $goalCarbs1, goalProtein: $goalPro1, goalFat: $goalFat1,goalRatio: $goalRatio, carbsIntake: $totalCarbs1,proteinIntake: $totalProtein1,fatIntake: $totalFat1)
                    .frame(maxWidth: .infinity, maxHeight: 140, alignment: .center)
                    .background(
                        Image("subsNavigationBackground")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            //.frame(width: .infinity, height: 140)
                            .opacity(0.95) // Arka planın opaklığını ayarlar
                    )
                    .cornerRadius(15)
                    .shadow(
                        color: Color(red: 0.87, green: 0.87, blue: 0.87, opacity: 0.25),
                        radius: 10
                    )
                    .padding(.horizontal, 25)

                
                HorizontalScrollView()
             
            } // ends of VStack
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            //Side Menu
            SideMenu(width: UIScreen.main.bounds.width * 2 / 3, menuOpened: menuOpened, toggleMenu: toggleMenu)
                .edgesIgnoringSafeArea(.all)
            // Side menu bottom height
                .padding(.bottom,-100)
            
        } // ends of ZStack
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            
            @ObservedObject var loginVM = LoginViewModel()
            loginVM.getDiet()
            
            // intake Calorie
            intakeCalorie = totalCalorie
            
            // intake fat, Carbs, Protein
            totalCarbs1 = totalCarbs
            totalFat1 = totalFat
            totalProtein1 = totalProtein
            
            // default değer
            burnedInt1 = burnedInt
            
            // goal
            goalInt1 = goalInt
            goalCarbs1 = goalCarbs
            goalFat1 = goalFat
            goalPro1 = goalPro
            goalRatio = ((totalCalorie - Double(burnedInt)) / goalInt) * 100.0
    
        }
        
    }
    
    func toggleMenu() {
        menuOpened.toggle()
    }
} // ends of MainView


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            //.environmentObject(navigationController)
            .preferredColorScheme(.light)
            
    }
}





