//
//  TitleView.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 10.07.2023.
//

import SwiftUI

struct TitleView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            // App Logo Rectangle
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 60, height: 60)
                .background(Color.clear)
                .cornerRadius(15)
                .overlay(
                    Image("App-Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                )
            
            // App Name Text
            Text(" Calorie Counter")
                .font(.custom(FontsManager.Poppins.bold, size: 26))
                .foregroundColor(Color("SamText"))
            
        }// ends of HStack
    }// ends of body
}


