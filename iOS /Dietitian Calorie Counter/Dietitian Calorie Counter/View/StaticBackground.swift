//
//  StaticBackground.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 7.07.2023.
//

import SwiftUI

struct StaticBackground: View {

    var body: some View {
        // 272 x 272
        CircleBackground(color: Color("PinkGradient"))
            .blur(radius: 100)
            .frame(width: 272, height: 272)
            .offset(x: 59, y: -68)

        // 201 x 201
        CircleBackground(color: Color("BlueGradient"))
            .blur(radius: 100)
            .frame(width: 201, height: 201)
            .offset(x: 170, y: 68)

        // 280 x 280
        CircleBackground(color: Color("BlueGradient"))
            .blur(radius: 100)
            .frame(width: 280, height: 280)
            .offset(x: -85, y: 269)

        // 230 x 231
        CircleBackground(color: Color("PinkGradient"))
            .blur(radius: 100)
            .frame(width: 230, height: 231)
            .offset(x: 141, y: 393)

        // 347x348
        CircleBackground(color: Color("PinkGradient"))
            .blur(radius: 100)
            .frame(width: 347, height: 348)
            .offset(x: -32, y: 651)

        // 222 x 201
        CircleBackground(color: Color("BlueGradient"))
            .blur(radius: 100)
            .frame(width: 222, height: 201)
            .offset(x: 130, y: 689)
    }
}

struct StaticBackground_Previews: PreviewProvider {
    static var previews: some View {
        StaticBackground()
    }
}
