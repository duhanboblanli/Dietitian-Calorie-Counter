//
//  Buttons.swift
//  ios_ai_cutter
//
//  Created by Mert Uludogan on 27.08.2023.
//

import Foundation
import SwiftUI

struct CloseButton: View{
    
    let action: () -> Void
    var size: CGFloat = 32
    var color: Color = Color(uiColor: UIColor(named: "SamText")!)
    @AppStorage("isDarkModeOn") var isOn = false
    
    var body: some View{
        Button(action: action){
            Image("x-mark")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .font(Font.system(size: size))
        }
    }
}

struct EditButton: View {
    
    var size: CGFloat = 48
    var color: Color = Color.white
    var action: () -> Void
    
    var body: some View{
        Button(action: {
            action()
        }){
            Text("EDIT".localized(LocalizationService.shared.language))
                .font(.custom(FontsManager.Poppins.semi_bold, size: 20))
                .foregroundColor( Color(uiColor: UIColor(named: "SamText")!) )
                .minimumScaleFactor(0.4)
        }
        .frame(width: 110, height: 35)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke( SamColors.tapToAICutGradient, lineWidth: 2)
        )
        .frame(height: 64)
    }
}

struct DownloadButton: View{
    
    var size: CGFloat = 48
    var color: Color = Color.white
    var isClosed: Bool
    var action: () -> Void

    var body: some View{
        let icon = Image("download-icon")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .font(Font.system(size: size))
            .foregroundColor(color)
        Button(action: {
            action()
        }){
            if(isClosed){
                icon
                    .opacity(0.5)
            }
            else{
                icon
            }
        }
    }
}

struct HomeButton: View{
    
    var size: CGFloat = 48
    var color: Color = Color.white
    var action: () -> Void
    
    var body: some View{
        Button(action: {
            action()
        }) {
            Image("home-icon")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .font(Font.system(size: size))
                .foregroundColor(color)
        }
    }
}

struct UploadButton: View {
    var size: CGFloat = 48
    var color: Color = Color.white
    var action: () -> Void

    var body: some View{
        Button(action: {
            action()
        }){
            Image("upload-icon")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .font(Font.system(size: size))
                .foregroundColor(color)
        }
    }
}

struct CustomBackButton: View {
    var title: String? = nil
    var action: (() -> Void)? = nil
    var closed: Binding<Bool>? = nil
    var font: Int = 24
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var navigationController: NavigationController
    
    var body: some View {
         
        Button(action: {
//            presentationMode.wrappedValue.dismiss()
            if let action = action {
                action()
            }
            else {
                navigationController.path.removeLast()
            }
            
        }) {
            HStack {
                Spacer().frame(width: 0)
                Image("arrow-back")
                    .resizable()
                    .frame(width: 32,height: 32)
                    .scaledToFit()
                if let title = title {
                    Spacer().frame(width: 9) // Add 12 points of spacing between the Image and Text
                    Text(title)
                        .font(.custom(FontsManager.Poppins.semi_bold, size: CGFloat(font)))
                }
            }
            .foregroundColor(Color("navigationBarTitle"))
        }
        .disabled(closed?.wrappedValue ?? false)
        .opacity(closed?.wrappedValue ?? false ? 0 : 1)
    }
}


struct DeleteBadgeIcon: View {
    
    var closed: Binding<Bool>? = nil
    
    var body: some View{
        Button(action:{}){
            Image("red_circle_minus")
                .resizable()
                .frame(width: 18, height: 18)
        }
        .disabled(closed?.wrappedValue ?? false)
        .opacity(closed?.wrappedValue ?? false ? 0 : 1)
        
    }
}
