//
//  HorizontalScrollView.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 10.07.2023.
//

import SwiftUI
import Photos

struct HorizontalScrollView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("language") private var language = LocalizationService.shared.language

    
    @State private var isPhotosEmpty = false
    @State private var isPhotoAccessAlertPresented = false
    @State var photosFetched = false
    @EnvironmentObject var navController: NavigationController
    

    let gridItem = GridItem(.flexible(minimum: 0), spacing: 20)
    
    var body: some View {
        
        VStack {
            Spacer()
            Text("recently-string".localized(language))
                .font(.custom(FontsManager.Poppins.light, size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 25)
                .padding(.top, 20)
                .foregroundColor(colorScheme == .dark ? Color(red: 0.96, green: 0.96, blue: 0.96) : Color(red: 0.09, green: 0.11, blue: 0.21))
       
            /*
            ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(photos) { photo in
                                    
                                    Button(action:{
                                        print("PHOTO: \(photo.image) \(photo.imageURL)")
                                        
                                        navController.preAICut(image: photo.image, imageURL: photo.imageURL)
                                        navController.path.append(.aicut)
                                    }){
                                        photo.photo
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .clipped()
                                            .background{
                                                RoundedRectangle(cornerRadius: 4)
                                                    .fill(Color.black.opacity(0.2))
                                                RoundedRectangle(cornerRadius: 4)
                                                    .stroke(Color.black.opacity(0.3))
                                                
                                            }
                                            .cornerRadius(15)
                                    }
                                }
                                .alert(isPresented: $isPhotosEmpty, content: {
                                    Alert(title: Text("no-photos-string"), message: Text("add-photos-string"), primaryButton: .default(Text("ok-string")), secondaryButton: .cancel())
                                })
                            }
                            .padding(.horizontal, 25)
                        } */
                        .frame(height: 120)
                        .onAppear(perform: {
                          
                        })
               
        }
        // HorizontalScrollView padding for tabbar
        .padding(.bottom, 32)
        
    }
}


