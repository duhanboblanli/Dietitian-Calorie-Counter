//
//  MenuItem.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 27.07.2023.
//

import Foundation

//Menu Item Model
struct MenuItem: Identifiable {
    var id = UUID()
    let text: String
    let imageName : String
}
