//
//  HomeView.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 20.09.2023.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool?

    var body: some View {
        ZStack {
            Color.red
            
            HStack {
                Text("HOME VIEW")
                Spacer()
                Button(action: { isOnboarding = true }, label: {
                    Text("Back")
                        .padding()
                        .background(
                            Capsule().strokeBorder(Color.white, lineWidth: 1.5)
                                .frame(width: 100)
                        )
                })
            }
            .padding(.horizontal,100)
            .navigationBarTitleDisplayMode(.inline) // Set the navigation bar title display mode to inline
            .navigationBarBackButtonHidden(true) // Hide the default back button
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

