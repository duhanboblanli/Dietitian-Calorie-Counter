//
//  NavigationLazyView.swift
//  ios_ai_cutter
//
//  Created by Mert Uludogan on 21.09.2023.
//

import Foundation
import SwiftUI


struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}




