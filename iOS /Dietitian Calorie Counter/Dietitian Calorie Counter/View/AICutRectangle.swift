//
//  AICutRectangle.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 10.07.2023.
//

import SwiftUI

struct AICutRectangle: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 160, height: 160)
                .background(
                    Color(red: 1, green: 1, blue: 1).opacity(0.30)
                )
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .strokeBorder(
                            LinearGradient(
                                gradient: Gradient(colors: [ThemeColors.editorButton.associatedColor, ThemeColors.cutterButton.associatedColor]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 2
                        )
                )
                .shadow(
                    color: Color(red: 0.87, green: 0.87, blue: 0.87, opacity: 0.25),
                    radius: 10
                )
            
            Image("tabler_photo-ai")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
                .padding(.leading, 40)
                .padding(.trailing, 40)
                .padding(.top, 26)
                .padding(.bottom, 54)
            
            Text("AI Cut")
                .font(Font.custom("Poppins", size: 16).weight(.medium))
                .foregroundColor(colorScheme == .dark ? Color(red: 0.96, green: 0.96, blue: 0.96) : Color(red: 0.40, green: 0.40, blue: 0.40))
                .frame(maxWidth: .infinity, alignment: .center)
                .lineLimit(1)
                .padding(.top, 122)
                .padding(.bottom, 14)
            
        }
//        VStack {
//            Button(action: {
//                isButtonClicked.toggle()
//            }) {
//
//                
//            }
//        }
    }
}

