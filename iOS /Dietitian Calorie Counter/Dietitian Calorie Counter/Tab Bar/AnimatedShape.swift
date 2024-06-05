//
//  AnimatedShape.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 10.07.2023.
//

import SwiftUI

// Custom curved shape
struct AnimatedShape: Shape {
    
    var centerX: CGFloat
    var centerY: CGFloat

    // Path Animating
    var animatableData: CGFloat{
        
        get{return centerX}
        set{centerX = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        return Path{path in
            var midPoint: CGFloat = 24
            var offsetY: CGFloat = 44
            var offsetCenter: CGFloat = 12
            print(rect)
            print(centerY)
            path.move(to: CGPoint(x: 0, y: midPoint + offsetY + offsetCenter))
            path.addQuadCurve(to: CGPoint(x: midPoint, y: offsetY + offsetCenter), control: CGPoint(x: 0, y: offsetY + offsetCenter))
            path.addLine(to: CGPoint(x: rect.midX - offsetY - offsetCenter, y: offsetY + offsetCenter))
            
            path.addQuadCurve(to: CGPoint(x: rect.midX - offsetY, y: offsetY), control: CGPoint(x: rect.midX - offsetY, y: offsetY + offsetCenter))
            
            path.addArc(center: CGPoint(x: rect.midX, y: offsetY), radius: offsetY, startAngle: .degrees(0), endAngle: .degrees(180), clockwise: true)
            
            path.addLine(to: CGPoint(x: rect.midX + offsetY, y: offsetY))
            path.addQuadCurve(to: CGPoint(x: rect.midX + offsetY + offsetCenter, y: offsetY + offsetCenter), control: CGPoint(x: rect.midX + offsetY, y: offsetY + offsetCenter))
            
            path.addLine(to: CGPoint(x: rect.width - midPoint, y: offsetY + offsetCenter))
            path.addQuadCurve(to: CGPoint(x: rect.width, y: midPoint + offsetY + offsetCenter), control: CGPoint(x: rect.width, y: offsetY + offsetCenter))
            
            
            
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))

            
            path.closeSubpath()
                
            // Curve
//            path.move(to: CGPoint(x: 0, y: 15))
//            path.addLine(to: CGPoint(x: 0, y: rect.height))
//            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
//            path.addLine(to: CGPoint(x: rect.width, y: 15))
//
//            // Curve
//            path.move(to: CGPoint(x: centerX - 52, y: 15))
//            path.addQuadCurve(to: CGPoint(x: centerX + 52, y: 15), control: CGPoint(x: centerX, y: -58))
        }
    }
}

