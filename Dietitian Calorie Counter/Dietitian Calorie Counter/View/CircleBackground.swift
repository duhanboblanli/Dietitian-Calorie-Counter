//
//  CircleBackground.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 7.07.2023

import SwiftUI

struct CircleBackground: View {
    @State var color: Color = Color("BlueGradient")
    
    var body: some View {
        Circle()
            .frame(width: 300, height: 300)
            .foregroundColor(color)
    }
}

struct CircleBackground_Previews: PreviewProvider {
    static var previews: some View {
        CircleBackground()
    }
}
