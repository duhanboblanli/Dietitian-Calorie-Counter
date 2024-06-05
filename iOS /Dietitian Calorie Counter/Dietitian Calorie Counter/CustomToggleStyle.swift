//
//  CustomToggleStyle.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 28.07.2023.
//

import Foundation
import SwiftUI

struct CustomToggleStyle:ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        let isOn = configuration.isOn
        return ZStack {
            RoundedRectangle(cornerRadius: 40, style: .continuous)
                .overlay(
                    RoundedRectangle(cornerRadius: 22)
                        .strokeBorder(
                            LinearGradient(
                                gradient: Gradient(colors: [Color("PinkGradient"), Color("BlueGradient")]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 2
                        )
)
                .frame(width: 138, height: 36)
                .foregroundColor(Color("SideMenuBackground"))
                .overlay(alignment: .leading) {
                    
                    Image("modeIcon")
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .offset(x: isOn ? 83.5 : 14.3)
                    Image("lightMode")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32)
                        .offset(x: 14)
                    Image("darkMode")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32)
                        .offset(x: 87)
                }
        }
        .onTapGesture {
            withAnimation {
                configuration.isOn.toggle()
            }
        }
    }
}


struct CustomToggleStyle_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(selectedMenuItem: "Settings")
    }
}
