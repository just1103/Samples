//
//  AppSettingsEntity.swift
//  Locale
//
//  Created by Hyoju Son on 12/28/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

@Model
final class AppSettingsEntity {
    var selectedLanguageCode: String

    init(selectedLanguageCode: String) {
        self.selectedLanguageCode = selectedLanguageCode
    }

    var languageOption: LanguageOptions {
        get {
            LanguageOptions(rawValue: selectedLanguageCode) ?? .english
        }
        set {
            selectedLanguageCode = newValue.rawValue
        }
    }
}
