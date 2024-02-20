//
//  SideMenu.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 27.07.2023.
//

import Foundation
import SwiftUI

// Side Menu Content with Animation
struct SideMenu: View {
    
    let width: CGFloat
    let menuOpened: Bool
    let toggleMenu: () -> Void
    
    var body: some View {
        ZStack {
            //Dimmed background view
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.05))
            .opacity(self.menuOpened ? 1 : 0)
            .animation(Animation.easeIn.delay(0.25), value: self.menuOpened)

            .onTapGesture {
                self.toggleMenu()
            }
            //Menu Content
            HStack {
                Spacer()
                MenuContent()
                    .frame(width: width, height: nil)
                    .offset(x: menuOpened ? 0 : width)
                    .animation(.default, value: self.menuOpened)
            }
        }
    }
}
