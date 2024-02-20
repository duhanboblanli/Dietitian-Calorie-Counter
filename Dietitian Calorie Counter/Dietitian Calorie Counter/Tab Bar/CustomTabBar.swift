//
//  CustomTabBar.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 10.07.2023.
//

import SwiftUI
import Photos
import PhotosUI

struct CustomTabBar : View {
    
    
    let tabItems = ["null0","Main","null1"]
    
    var centerY: Binding<CGFloat>
    @EnvironmentObject var navController: NavigationController
    @EnvironmentObject var viewModel: MainViewModel
    @State var isPhotoPickerTaskWorking: Bool = false
    var body: some View {
        
        // Custom TabBar
        HStack(spacing: 0.0) {
            ForEach(tabItems, id: \.self) { value in
                PhotoPickerTabBarItem(value: value, tabItems: tabItems, centerY: centerY)
            }
        }
        .padding(.top, 12)
        .padding(.bottom, 12)// ends of HStack
    }
    struct PhotoPickerTabBarItem: View{
        
        var value: String
        let tabItems: [String]
        var centerY: Binding<CGFloat>
        @EnvironmentObject var viewModel: MainViewModel
        @EnvironmentObject var navController: NavigationController
        @State var selectedItem: PhotosPickerItem? = nil
        
        var body: some View{
            PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()
                ){
                        TabBarButton(value: value)
                        .background{
                            GeometryReader{reader in
                                Color.clear
                                    .onAppear{
                                        if(value == tabItems[1]){
                                            let frame = reader.frame(in: .global)
                                            centerY.wrappedValue = frame.minY + frame.height / 2 - 12
                                        }
                                    }
                            }
                        }
                }
                .onChange(of: selectedItem) { newItem in
                    Task{
                        let (image, url) = await viewModel.photosPickerTask(newItem: newItem)
                        if let image = image, let url = url{
                            print("PICKER: \(image) \(url)")

                            navController.preAICut(image: image, imageURL: url)

                            
                            DispatchQueue.main.async {
                                navController.path.append(.aicut)
                            }
                        }
                    }
                }
                .onAppear{
                    selectedItem = nil
                }
                if value != tabItems.last{
                    Spacer(minLength: 0)
                }
        }
        
    }
    

}



