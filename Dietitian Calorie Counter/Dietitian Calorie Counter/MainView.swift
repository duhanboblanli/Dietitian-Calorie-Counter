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
    @AppStorage("isOnboarding") var isOnboarding = false

    @State var centerY: CGFloat = 0
    @State var menuOpened = false
    @State private var cur_tag = 0
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        VStack(spacing: 0.0) {
            mainView
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
                    .padding(.top,20) // 20 + 16(default) = 36
                    .padding(.horizontal, 25)
                    .padding(.bottom, 20)

                
                HorizontalScrollView()
                // AdBannerView(adUnitID: "ca-app-pub-3940256099942544/2934735716").frame(height: 50)
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
                        
            
        }
        
    }
    
    func toggleMenu() {
        menuOpened.toggle()
    }
} // ends of MainView








