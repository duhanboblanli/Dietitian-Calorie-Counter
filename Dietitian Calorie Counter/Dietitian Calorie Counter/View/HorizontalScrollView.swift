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
    
    @ObservedObject var networkManager = NetworkManager.shared
    @State var term : String = ""
    @State var selectedFoodType = 1
    
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
             
             }
             .padding(.horizontal, 25)
             } */
            ScrollView(.horizontal) {
                LazyHStack {
                    //SearchBar(text: $term)
                    
                    /*
                     // Segmented Controls : Common or Branded Food Types
                     Picker(selection: $selectedFoodType, label: Text("")) {
                     Text("Branded").tag(0)
                     Text("Common").tag(1)
                     }.pickerStyle(SegmentedPickerStyle()) */
                    
                    // Check the food type : Branded or Common
                    if selectedFoodType == 0 {
                        ForEach(networkManager.brandedProducts, id: \.food_name) { food in
                            BrandedTableList(brandedProduct: food)
                        }
                    } else {
                        ForEach(networkManager.commonProducts, id: \.food_name) { food in
                            CommonTableList1(commonProduct: food)
                        }
                    }
                }
            }
            .padding(.leading,25)
            
            .frame(height: 120)
            .onAppear {
                NetworkManager.shared.performQuery(query : "chee")
                
            }
            
            
        }
        // HorizontalScrollView padding for tabbar
        .padding(.bottom, 32)
        
        
    }
}

struct CommonTableList1 : View {
    //**************** Variables ****************\\
    //    @EnvironmentObject var session: SessionStore
    @ObservedObject var networkManager = NetworkManager.shared
    @State var isShowingFoodDetailView = false
    @State var isShowingItemDetailView = false
    var commonProduct : Common
    
    var body: some View {
        HStack {
            ImageView(imageURL: commonProduct.photo.thumb, vWidth: 90, vHeight: 90)
            
        }.onTapGesture() {
            print(self.commonProduct.food_name)
            self.networkManager.getCommonFoodItemDetails(food_name: self.commonProduct.food_name, callback: {
                self.isShowingFoodDetailView.toggle()
            })
            
        }.sheet(isPresented: $isShowingFoodDetailView, content: {FoodDetailedView()})
        
        //        .sheet(isPresented: $isShowingFoodDetailView, content: {FoodDetailedView().environmentObject(self.session)})
            .contextMenu {
                // Show a bigger preview of the food item
                Button(action: {
                    // View More
                    self.isShowingItemDetailView.toggle()
                }) {
                    HStack {
                        Text("View More")
                        Image(systemName: "doc.text.magnifyingglass")
                    }
                }.sheet(isPresented: $isShowingItemDetailView, content: {
                    ItemDetailView(itemImageURL: self.commonProduct.photo.thumb, itemName: self.commonProduct.food_name)
                })
            }
    }
}
