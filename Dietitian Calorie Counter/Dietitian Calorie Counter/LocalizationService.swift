//
//  LocalizationService.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 11.09.2023.
//

import Foundation

enum Language: String {
    case english = "en"
    case turkish = "tr"
    case spanish = "es"
    case german = "de"
    case french = "fr"
    case italian = "it"
    case russian = "ru"
    case japanese = "ja"
    case simplifiedChinese = "zh-Hans"
}

class LocalizationService {

    static let shared = LocalizationService()
    static let changedLanguage = Notification.Name("changedLanguage")

    private init() {}
    
    var language: Language {
        get {
            guard let languageString = UserDefaults.standard.string(forKey: "language") else {
                return .english
            }
            return Language(rawValue: languageString) ?? .english
        } set {
            if newValue != language {
                UserDefaults.standard.setValue(newValue.rawValue, forKey: "language")
                NotificationCenter.default.post(name: LocalizationService.changedLanguage, object: nil)
            }
        }
    }
}
