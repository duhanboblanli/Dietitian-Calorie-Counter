//
//  Colors.swift
//  scratching
//
//  Created by Mert Uludogan on 10.07.2023.
//

import Foundation
import UIKit
import SwiftUI

struct CustomShadow: ViewModifier {
    var color: Color
    var radius: CGFloat
    var x: CGFloat
    var y: CGFloat
    
    func body(content: Content) -> some View {
        content
            .shadow(color: color, radius: radius, x: x, y: y)
    }
}

class SamColors{
    
    
    struct Shadow{
        let color: Color
        let radius: CGFloat
        let x: CGFloat
        let y: CGFloat

        static let samButtonShadow = Shadow(color: Color(red: 0.71, green: 0.71, blue: 0.71).opacity(0.25), radius: 4, x: 0, y: 4)
    }
    
    
    static let tapToAICutGradient = LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.95, green: 0.71, blue: 0.83), location: 0.00),
            Gradient.Stop(color: Color(red: 0.48, green: 0.87, blue: 0.95), location: 1.00),
            ],
        startPoint: UnitPoint(x: 0, y: 0),
        endPoint: UnitPoint(x: 1, y: 1)
    )

    
    
    static let subscriptionGradient = LinearGradient(
        stops: [
        Gradient.Stop(color: Color(uiColor: UIColor(named: "CommonPos")!).opacity(0), location: 0.00),
        Gradient.Stop(color: Color(uiColor: UIColor(named: "CommonPos")!), location: 0.49),
        ],
        startPoint: UnitPoint(x: 0.5, y: 0),
        endPoint: UnitPoint(x: 0.5, y: 1)
        )
    static let ellipseColor = Color(red: 0.48, green: 0.87, blue: 0.95)


    
}


