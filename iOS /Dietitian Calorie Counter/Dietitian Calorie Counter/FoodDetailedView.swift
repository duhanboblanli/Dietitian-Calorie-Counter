//
//  FoodDetailedView.swift
//  CalTrack
//
//  Created by Jalp on 20/01/2020.
//  Copyright © 2020 jdc0rp. All rights reserved.
//

import SwiftUI
import Combine
//import FirebaseFirestore

//**************** Shows nutritional values for a given food item ****************\\
struct FoodDetailedView: View {
    //**************** Variables ****************\\
    @State var quantity : Int = 1
    @State var isShowingAlert = false
    @State var dismissView = false
    @State var alertMsg = ""
    @State var alertMsgBody = ""
    
    // intake
    @AppStorage("totalCalorie") var totalCalorie = 0.0
    @AppStorage("totalCarbs") var totalCarbs = 0.0
    @AppStorage("totalProtein") var totalProtein = 0.0
    @AppStorage("totalFat") var totalFat = 0.0


//    @EnvironmentObject var session : SessionStore
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    @ObservedObject var networkManager = NetworkManager.shared
//    @ObservedObject var goal = DBManager.shared
    var foodEnergy = FoodEnergy.shared
    
    // Tracks the calories of the food
    func trackFood() {
        // If the user didn't specify quantity alert them
        if (quantity == 0) {
            self.isShowingAlert = true
            self.alertMsg = "Error"
            self.alertMsgBody = "Quantity must be 1 or more"
            self.dismissView = false
        } else {
            print("Serving quantity selected : \(quantity)")
            let food = FoodEnergy.shared
            let calorie = food.energy * Double(quantity)
            let carbs = food.carbs * Double(quantity)
            let protein = food.protein * Double(quantity)
            let fat = food.fat * Double(quantity)
            
            print("calorie: ",calorie,"carbs: ",carbs,"protein: ",protein,"fat: ",fat)
            
            DispatchQueue.main.async {
                LoginViewModel().putDiet(intakeCal: calorie, intakeCarbohydrate: carbs, intakeFat: fat , intakeProtein: protein)
            }

            totalCalorie += calorie
            totalCarbs += carbs
            totalProtein += protein
            totalFat += fat
 
            
            print("calorie: ",totalCalorie,"carbs: ",totalCarbs,"protein: ",totalProtein,"fat: ",totalFat)

            
            self.alertMsg = "Success"
            self.alertMsgBody = "Food has been tracked!"
            self.isShowingAlert = true
            self.dismissView = true
            
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                ImageView(imageURL: networkManager.foodDetail.first!.photo.thumb,vWidth: 90, vHeight: 90)
                    .frame(width: 120, height: 120, alignment: .center)
                    .aspectRatio(contentMode: .fit)
                
                VStack {
                    HStack {
                        Text("\(networkManager.foodDetail.first!.food_name)")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                            .frame(alignment: .leading)
                        Spacer()
                    }
                    HStack {
                        Text("\(networkManager.foodDetail.first!.brand_name ?? "Common Food")")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(4)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
                Spacer(minLength: 40)
            }
            Spacer()
            
            HStack {
                Spacer()
                NutritionalLabelView(energyValue: foodEnergy.energyV, energyPercent: foodEnergy.energyRV, energyColor: foodEnergy.energyColor, energyJ : foodEnergy.energyKJ, sugarsValue: foodEnergy.sugarV, sugarsPercent: foodEnergy.sugarRV, sugarsColor: foodEnergy.sugarColor, saltValue: foodEnergy.saltV, saltPercent: foodEnergy.saltRV, saltColor: foodEnergy.saltColor, carbsValue: foodEnergy.carbsV, carbsPercent: foodEnergy.carbsRV, carbsColor: foodEnergy.carbsColor, proteinValue: foodEnergy.proteinV, proteinPercent: foodEnergy.proteinRV, proteinColor: foodEnergy.proteinColor, fatValue: foodEnergy.fatV, fatPercent: foodEnergy.fatRV, fatColor: foodEnergy.fatColor)
                    
                    
                    .frame(width : ScreenBounds.deviceWidth - 10, alignment: .center)
                Text("")
                Spacer()
            }
            
            Spacer()
            HStack {
                Image(systemName: "info.circle.fill")
                VStack(alignment: .leading) {
                    Text("of the reference intake*")
                        .bold()
                        .font(.caption)
                    Text("Typical values per 100g: Energy 1243kJ / 297kcal")
                        .bold()
                        .font(.caption)
                }
            }
            Spacer()
            
            Stepper(value: $quantity, in: 1...100) {
                Text("Serving \(quantity)")
            }.padding(.all)
            
            Spacer()
            
            Button(action: trackFood) {
                Text("Track")
                    .foregroundColor(.black)
                    .frame(minWidth: 0, maxWidth: ScreenBounds.deviceWidth - 250)
                    .padding(12)
                    .padding(.horizontal, 30)
                    .background(Color(#colorLiteral(red: 0.8767055458, green: 0.1087125435, blue: 0.1915467579, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0.8767055458, green: 0.1087125435, blue: 0.1915467579, alpha: 1)).opacity(0.2), radius: 16, x: 0, y: 20)
            }
            
            Spacer()
        }.alert(isPresented: $isShowingAlert, content: {
            Alert(title: Text(alertMsg), message: Text(alertMsgBody), dismissButton: .default(Text("Okay")) {
                if (self.dismissView) {
                    self.presentation.wrappedValue.dismiss()
                }
                })
        })
        
    }
}

struct FoodDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailedView()
    }
}

