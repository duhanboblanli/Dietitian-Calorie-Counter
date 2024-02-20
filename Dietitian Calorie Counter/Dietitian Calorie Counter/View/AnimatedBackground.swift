//
//  AnimatedBackground.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 7.07.2023.
//

import SwiftUI

struct AnimatedBackground: View {
    @State var animate = false
    var body: some View {
        // 272 x 272
        CircleBackground(color: Color("PinkGradient"))
            .blur(radius: 100)
            .frame(width: 272, height: 272)
            .offset(x: animate ? 59 : 253, y: animate ? -68 : 0)
            .task {
                withAnimation(.easeInOut(duration: 7).repeatForever()) {
                    animate.toggle()
                }
            }

        // 201 x 201
        CircleBackground(color: Color("BlueGradient"))
            .blur(radius: 100)
            .frame(width: 201, height: 201)
            .offset(x: animate ? 170:-31, y: animate ? 68:19)
            
        // 280 x 280
        CircleBackground(color: Color("BlueGradient"))
            .blur(radius: 100)
            .frame(width: 280, height: 280)
            .offset(x: animate ? -85:191, y: animate ? 269:341)
           

        // 230 x 231
        CircleBackground(color: Color("PinkGradient"))
            .blur(radius: 100)
            .frame(width: 230, height: 231)
            .offset(x: animate ? 141:-60, y: animate ? 393:306)
            
        // 347x348
        CircleBackground(color: Color("PinkGradient"))
            .blur(radius: 100)
            .frame(width: 347, height: 348)
            .offset(x: animate ? -32:0, y: animate ? 651:621)
           
        // 222 x 201
        CircleBackground(color: Color("BlueGradient"))
            .blur(radius: 100)
            .frame(width: 222, height: 201)
            .offset(x: animate ? 130:31, y: animate ? 689:715)
    }
}

struct AnimatedBackground_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedBackground()
    }
}
