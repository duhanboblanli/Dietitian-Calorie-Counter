//
//  FAQItem.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 30.09.2023.
//

import Foundation

//Model
struct FAQItem: Identifiable {
    let id = UUID()
    let questionNumber: String
    let question: String
    let answer: String
    var isExpanded: Bool = false
}
