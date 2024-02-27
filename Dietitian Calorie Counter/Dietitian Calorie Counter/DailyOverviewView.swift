//
//  DailyOverviewView.swift
//  Dietitian Calorie Counter
//
//  Created by Duhan Boblanlı on 23.02.2024.
//

import Foundation
import SwiftUI


//**************** Referenced : https://exyte.com/blog/swiftui-tutorial-replicating-activity-application?utm_source=reddit&utm_medium=referral&utm_campaign=website_blog ****************\\
//**************** Circular Progress Bar ****************\\
struct CiruclarProgress : View {
    @State var show = false
    var body: some View {
        Circle()
            .trim(from: show ? 0.1 : 0.99, to: 1)
            .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            .rotationEffect(.degrees(90))
            .rotation3DEffect(Angle(degrees: 100), axis: (x: 0, y: 1, z: 0))
            .frame(width: 100, height: 100)
            .animation(.easeOut)
            .onTapGesture {
                self.show.toggle()
        }
    }
}

//**************** Background for Circular Progress ****************\\
struct CircularBackgroundView: Shape {
    var thicc: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.width / 2, y: rect.height / 2),
            radius: rect.width / 2 - thicc,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 360),
            clockwise: false
        )
        return path
            .strokedPath(.init(lineWidth: thicc, lineCap: .round, lineJoin: .round))
    }
}

//**************** Shape for the circular progress ****************\\
struct CircularShape: Shape {
    var currentProgress: Double
    var thicc: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.width / 2, y: rect.height / 2),
            radius: rect.width / 2 - thicc,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 360 * (currentProgress / 100)),
            clockwise: false
        )
        
        return path
            .strokedPath(.init(lineWidth: thicc, lineCap: .round, lineJoin: .round))
    }
    // Animate the circular progress view
    var animatableData: Double {
        get { return currentProgress }
        set { currentProgress = newValue }
    }
}

//**************** Animated Circualr Progress Bar ****************\\
struct CircleView: View {
    //**************** Variables ****************\\
    @State var currentProgress: Double = 0 {
        didSet {
            // Animate everytime the value changes
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(self.animation) {
                    self.currentProgress = self.percentage
                }
            }
        }
    }
    var bkColor: Color
    var startColor: Color
    var endColor: Color
    var thicc: CGFloat
    var animation: Animation {
        Animation.easeInOut(duration: 0.9)
    }
    @Binding var percentage: Double
    
    var body: some View {
        
        let gradient = LinearGradient(
                    gradient: Gradient(colors: [startColor, endColor]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
        
        return ZStack {
            CircularBackgroundView(thicc: thicc)
                .fill(bkColor)
            CircularShape(currentProgress: currentProgress, thicc: thicc)
                .fill(gradient)
                .rotationEffect(.init(degrees: -90))
                .shadow(radius: 2)
                .drawingGroup()
                
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(self.animation) {
                            self.currentProgress = self.percentage
                        }
                    }
            }
        }
    }
}

//**************** Show the calorific progress of a user ****************\\
struct DailyOverView : View {
    @State var initial: CGFloat = 0.0
    @State var value: CGFloat = 0.0
    @Binding var intake: Double
    @Binding var caloriesBurned: Int
    @Binding var goalSetToday: Double
    @Binding var goalRatio : Double
    @Binding var carbsIntake : Double
    @Binding var proteinIntake : Double
    @Binding var fatIntake : Double
    @Environment(\.colorScheme) var colorScheme

    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Spacer()
                HStack {
                    // Text Linear Gradient Bold
                    LinearGradient(
                        gradient: Gradient(colors: [Color("subsPinkGradient"), Color("subsBlueGradient")]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .mask(Text("Eaten :")
                        .font(.custom(FontsManager.Poppins.bold, size: 18))
                        .multilineTextAlignment(.leading)
                    )
                    .frame(maxWidth: 80, alignment: .leading) // Texti sola daya
                    .padding(.leading,1)

                    Spacer().frame(width: 3)

                    
                    Text("\(String(format: "%.0f", self.intake)) kcal")
                        .font(.custom(FontsManager.Poppins.medium, size: 18 ))
                        .foregroundColor(colorScheme == .dark ? Color(red: 0.09, green: 0.11, blue: 0.21) : Color(red: 0.96, green: 0.96, blue: 0.96))
                        .lineLimit(1)
                        .frame(maxWidth: 90, alignment: .leading) // Texti sola daya
                }
                .padding(.leading,0)

                Spacer().frame(height: 0)
                
                HStack {
                    // Text Linear Gradient Bold
                    LinearGradient(
                        gradient: Gradient(colors: [Color("subsPinkGradient"), Color("subsBlueGradient")]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .mask(Text("Burned :")
                        .font(.custom(FontsManager.Poppins.bold, size: 18))
                        .multilineTextAlignment(.leading)
                    )
                    .frame(maxWidth: 80, alignment: .leading) // Texti sola daya
                    .padding(.leading,6)

                    Spacer().frame(width: 0)
                    
                    Text("\(String(format: "%.0f", Double(self.caloriesBurned))) kcal")
                        .font(.custom(FontsManager.Poppins.medium, size: 18 ))
                        .foregroundColor(colorScheme == .dark ? Color(red: 0.09, green: 0.11, blue: 0.21) : Color(red: 0.96, green: 0.96, blue: 0.96))
                        .lineLimit(1)
                        .frame(maxWidth: 90, alignment: .leading) // Texti sola daya
                }
                Spacer().frame(height: 0)

                HStack {
                    // Text Linear Gradient Bold
                    LinearGradient(
                        gradient: Gradient(colors: [Color("subsPinkGradient"), Color("subsBlueGradient")]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .mask(Text("Goal :")
                        .font(.custom(FontsManager.Poppins.bold, size: 18))
                        .multilineTextAlignment(.leading)
                    )
                    .frame(maxWidth: 80, alignment: .leading) // Texti sola daya
                    .padding(.leading,-1)

                    //Spacer().frame(width: 6)
                    Spacer().frame(width: 4)

                    Text("\(String(format: "%.0f", Double(self.goalSetToday))) kcal")
                        .font(.custom(FontsManager.Poppins.medium, size: 18 ))
                        .foregroundColor(colorScheme == .dark ? Color(red: 0.09, green: 0.11, blue: 0.21) : Color(red: 0.96, green: 0.96, blue: 0.96))
                        .lineLimit(1)
                        .frame(maxWidth: 90, alignment: .leading) // Texti sola daya
                        

                }
                
                Spacer()
            }
            .padding(.leading,4)
            Spacer().frame(width: 30)
            ZStack {
                Text("\(String(format: "%.2f", self.goalRatio))%")
                    .font(.custom(FontsManager.Poppins.medium, size: 17 ))
                    .foregroundColor(colorScheme == .dark ? Color(red: 0.09, green: 0.11, blue: 0.21) : Color(red: 0.96, green: 0.96, blue: 0.96))
                
                CircleView(currentProgress: goalRatio, bkColor: Color("greybkg").opacity(1), startColor: Color("subsBlueGradient"), endColor: Color("subsPinkGradient").opacity(0.9), thicc: 19.0, percentage: self.$goalRatio)
                    .frame(width: 130, height: 130)
                    .aspectRatio(contentMode: .fit)
            }
        }
        let totalCalories = self.goalSetToday // Toplam günlük kalori alımı

        // Önerilen yüzdelik oranlar
        let carbPercentage = 0.50 // %50
        let proteinPercentage = 0.25 // %25
        let fatPercentage = 0.25 // %25

        // Günlük karbonhidrat, protein ve yağ ihtiyaçlarını hesaplayın
        let carbCalories = Double(totalCalories) * carbPercentage
        let proteinCalories = Double(totalCalories) * proteinPercentage
        let fatCalories = Double(totalCalories) * fatPercentage

        // Kalori başına gram cinsinden karbonhidrat, protein ve yağ değerlerini belirtin
        let carbCaloriesPerGram = 4.0 // 1 gram karbonhidrat = 4 kcal
        let proteinCaloriesPerGram = 4.0 // 1 gram protein = 4 kcal
        let fatCaloriesPerGram = 9.0 // 1 gram yağ = 9 kcal

        // Günlük karbonhidrat, protein ve yağ ihtiyacını gram cinsinden hesaplayın
        let carbGrams = carbCalories / carbCaloriesPerGram
        let proteinGrams = proteinCalories / proteinCaloriesPerGram
        let fatGrams = fatCalories / fatCaloriesPerGram
        
        HStack {
            // Başlık: Carbs
           
            VStack {
                Spacer()
                
                Text("Carbs")
                    .font(.custom(FontsManager.Poppins.bold, size: 17))
                    .foregroundColor(colorScheme == .dark ? Color(red: 0.09, green: 0.11, blue: 0.21) : Color(red: 0.96, green: 0.96, blue: 0.96))
                
                Spacer().frame(height: 10)
                
                CustomLinearProgressBar(value: carbsIntake, total: carbGrams, barWidth: 300, barHeight: 5, gradientColors: [Color("subsBlueGradient"), Color("subsPinkGradient")])
                    .frame(height: 5)
                    
                    
                Spacer().frame(height: 10)
                
                Text("\(String(format: "%.1f", carbsIntake)) / \(Int(carbGrams))g")
                    .font(.custom(FontsManager.Poppins.bold, size: 14))
                    .foregroundColor(colorScheme == .dark ? Color(red: 0.09, green: 0.11, blue: 0.21) : Color(red: 0.96, green: 0.96, blue: 0.96))
                
                Spacer()
            }
            .padding(.leading,10)
            .padding(.trailing, 10)
            
            // Başlık: Protein
            VStack {
                Text("Protein")
                    .font(.custom(FontsManager.Poppins.bold, size: 17))
                    .foregroundColor(colorScheme == .dark ? Color(red: 0.09, green: 0.11, blue: 0.21) : Color(red: 0.96, green: 0.96, blue: 0.96))
           
                
                Spacer().frame(height: 10)
                
                CustomLinearProgressBar(value: proteinIntake, total: proteinGrams, barWidth: 300, barHeight: 5, gradientColors: [Color("subsBlueGradient"), Color("subsPinkGradient")])
                    .frame(height: 5)
                    
                    
                Spacer().frame(height: 10)
                Text("\(String(format: "%.1f", proteinIntake)) / \(Int(proteinGrams))g")

                    .font(.custom(FontsManager.Poppins.bold, size: 14))
                    .foregroundColor(colorScheme == .dark ? Color(red: 0.09, green: 0.11, blue: 0.21) : Color(red: 0.96, green: 0.96, blue: 0.96))
            }
            .padding(.trailing, 10)
            
            // Başlık: Fat
            VStack {
                Text("Fat")
                    .font(.custom(FontsManager.Poppins.bold, size: 17))
                    .foregroundColor(colorScheme == .dark ? Color(red: 0.09, green: 0.11, blue: 0.21) : Color(red: 0.96, green: 0.96, blue: 0.96))
               
                
                Spacer().frame(height: 10)
                
                CustomLinearProgressBar(value: fatIntake, total: fatGrams, barWidth: 300, barHeight: 5, gradientColors: [Color("subsBlueGradient"), Color("subsPinkGradient")])
                    .frame(height: 5)
                    
                    
                Spacer().frame(height: 10)
                
                
                Text("\(String(format: "%.1f", fatIntake)) / \(Int(fatGrams))g")
                    .font(.custom(FontsManager.Poppins.bold, size: 14))
                    .foregroundColor(colorScheme == .dark ? Color(red: 0.09, green: 0.11, blue: 0.21) : Color(red: 0.96, green: 0.96, blue: 0.96))
            }
            .padding(.trailing, 10)
            
        }
       
      
       
    }
}


struct DailyOverView_Previews: PreviewProvider {
    static var previews: some View {
        // Önizleyiciye bağlayıcıları geçirmek için sabit değerler 
        /*oluşturuyoruz
        let intake = Binding<Double>.constant(1500)
        let caloriesBurned1 = Binding<Int>.constant(500)

        let caloriesBurned = Binding<Double>.constant(200)
        let goalSetToday = Binding<Double>.constant(2000)
        let ratio = ((1500.0 - 500.0) / 2000.0) * 100.0
        let goalRatio = Binding<Double>.constant(ratio)
        
        return DailyOverView(intake: intake, caloriesBurned: caloriesBurned1, goalSetToday: goalSetToday, goalRatio: goalRatio,carbsIntake: caloriesBurned,proteinIntake: caloriesBurned,fatIntake: caloriesBurned)
        */
        MainView()
            //.environmentObject(navigationController)
            .preferredColorScheme(.light)
    }
}

struct CustomLinearProgressBar: View {
    var value: Double // Mevcut değer
    var total: Double // Toplam değer
    var barWidth: CGFloat // Çubuğun genişliği
    var barHeight: CGFloat // Çubuğun yüksekliği
    var gradientColors: [Color] // Lineer gradyan renkleri
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: barHeight / 2)
                    .frame(width: geometry.size.width, height: barHeight)
                    .foregroundColor(Color.gray.opacity(0.5)) // Arka plan rengi
                
                RoundedRectangle(cornerRadius: barHeight / 2)
                    .frame(width: min(self.progressBarWidth(geometryWidth: geometry.size.width), geometry.size.width), height: barHeight)
                    .foregroundColor(.clear)
                    .background(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing))
                    .clipShape(RoundedRectangle(cornerRadius: barHeight / 2))
            }
            .frame(height: barHeight)
        }
    }
    
    // İlerleme çubuğunun genişliğini hesapla
    private func progressBarWidth(geometryWidth: CGFloat) -> CGFloat {
        let percent = min(max(0, CGFloat(value / total)), 1)
        return percent * geometryWidth
    }
}
