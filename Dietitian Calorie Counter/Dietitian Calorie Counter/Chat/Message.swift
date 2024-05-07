//
//  Message.swift
//  ChatApp
//
//  Created by Stephanie Diep on 2022-01-11.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String // Random UUID()
    var text: String
    var received: Bool
    var timestamp: Date
}
