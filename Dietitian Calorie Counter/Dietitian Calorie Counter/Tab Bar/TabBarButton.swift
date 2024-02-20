//
//  TabBarButton.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 10.07.2023.
//

import SwiftUI

struct TabBarButton: View {
    
    var value : String
    @State private var tabbarButtonPressed: Bool = false

    var body: some View{
        // Icons
        HStack {
            Image(value)
                .resizable()
                .renderingMode(.template)
                .frame(width: 64, height: 64)
        }
        .foregroundStyle(.linearGradient(colors: [ThemeColors.editorButton.associatedColor, ThemeColors.cutterButton.associatedColor], startPoint: .top, endPoint: .bottom))
    }
}

struct TabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
