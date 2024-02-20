//
//  FAQView.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 27.07.2023.
//

import SwiftUI

struct FAQView: View {
    // NavigationBar Back Button Title
    let selectedMenuItem: String
        
    @State private var faqItems: [FAQItem] = [
        FAQItem(
            questionNumber: "1",
            question: "Q1".localized(LocalizationService.shared.language),
            answer: "A1".localized(LocalizationService.shared.language)
        ),
        FAQItem(
            questionNumber: "2",
            question: "Q2".localized(LocalizationService.shared.language),
            answer: "A2".localized(LocalizationService.shared.language)
        ),
        FAQItem(
            questionNumber: "3",
            question: "Q3".localized(LocalizationService.shared.language),
            answer: "A3".localized(LocalizationService.shared.language)
        ),
        FAQItem(
            questionNumber: "4",
            question: "Q4".localized(LocalizationService.shared.language),
            answer: "A4".localized(LocalizationService.shared.language)
        ),
        FAQItem(
            questionNumber: "5",
            question: "Q5".localized(LocalizationService.shared.language),
            answer: "A5".localized(LocalizationService.shared.language)
        ),
        FAQItem(
            questionNumber: "6",
            question: "Q6".localized(LocalizationService.shared.language),
            answer: "A6".localized(LocalizationService.shared.language)
        ),
        FAQItem(
            questionNumber: "7",
            question: "Q7".localized(LocalizationService.shared.language),
            answer: "A7".localized(LocalizationService.shared.language)
        )
    ]
    
    var body: some View {

        ZStack {
            Color("SideMenuBackground")
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    
                    ForEach(faqItems.indices, id: \.self) { index in
                        FAQItemView(questionNumber: faqItems[index].questionNumber, question: faqItems[index].question, answer: faqItems[index].answer, isExpanded: $faqItems[index].isExpanded)
                    }
                    Spacer()
                }// ends of VStack
                .padding(.top)
            }// ends of ScrollView
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton(title: selectedMenuItem))
            // NavigationBar Color - Don't use .edgesIgnoringSafeArea() with navigationBar
            .background(Color("SideMenuBackground"))
        } // ends of ZStack
    } // ends of NavigationStack
    
}

struct FAQItemView: View {
    let questionNumber: String
    let question: String
    let answer: String
    @Binding var isExpanded: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            //MARK: - Question
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack(alignment: .top) {
                    Text(questionNumber + ".")
                    HStack {
                        Text("\(question)")
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    }
                    .font(.custom(FontsManager.Poppins.medium, size: 16))
                }
                .foregroundColor(Color("questionTextColor"))
                .padding(.horizontal, 25)
            }
            //MARK: - Answer
            if isExpanded {
                Text("\(answer)")
                    .multilineTextAlignment(.leading)
                    .font(.custom(FontsManager.Poppins.medium, size: 14))
                    .foregroundColor(Color("answerTextColor"))
                    .padding(.horizontal, 45)
                    .opacity(isExpanded ? 1.0 : 0.0)
                    .transition(.opacity)
            }
        }
    }
}

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView(selectedMenuItem: "FAQ's")
    }
}

