//
//  Colors.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 6.07.2023.
//

import SwiftUI

enum ThemeColors {
    case blueGradient
    case pinkGradient
    case editorButton
    case cutterButton
  
    // If using color with type Color
    var associatedColor: Color {
        switch self {
        case .blueGradient:
            return Color("BlueGradient")
        case .pinkGradient:
            return Color("PinkGradient")
        case .editorButton:
            return Color("EditorButton")
        case .cutterButton:
            return Color("CutterButton")
        }
    }
}

