//
//  LanguageManager.swift
//  Sportify
//
//  Created by Esraa Ehab on 06/06/2026.
//

import Foundation

final class LanguageManager {

    static let shared = LanguageManager()

    private init() {}

    func setLanguage(languageCode: String) {

        UserDefaults.standard.set(
            [languageCode],
            forKey: "AppleLanguages"
        )

        UserDefaults.standard.synchronize()

        Bundle.setLanguage(languageCode)
    }

    var currentLanguage: String {
        UserDefaults.standard.string(forKey: "selectedLanguage") ?? "en"
    }
}
