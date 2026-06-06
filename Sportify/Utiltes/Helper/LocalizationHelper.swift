//
//  LocalizationHelper.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 06/06/2026.
//

import Foundation
import UIKit

class LocalizationHelper {
    static let shared = LocalizationHelper()
    
    private init() {}
    
    func localizedString(forKey key: String) -> String {
        let language = UserDefaultsManager.shared.appLanguage.rawValue
        
        // Try to get the bundle for the selected language
        if let path = Bundle.main.path(forResource: language, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: key, value: nil, table: nil)
        }
        
        // Fallback to main bundle
        return NSLocalizedString(key, comment: "")
    }
}

