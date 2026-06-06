//
//  UserDefaultsManager.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 04/06/2026.
//

import Foundation

enum AppTheme: String {
    case light
    case dark
}

enum AppLanguage: String {
    case arabic = "ar"
    case base = "Base"
}

protocol OnboardingStorage {
    var isFirstVisit: Bool { get set }
}

protocol AppSettingsStorage {
    var appTheme: AppTheme { get set }
    var appLanguage: AppLanguage { get set }
}


final class UserDefaultsManager: OnboardingStorage, AppSettingsStorage{
    
    static let shared = UserDefaultsManager()
    private let storage: UserDefaults
    
    init(storage: UserDefaults = .standard) {
        self.storage = storage
    }
    
    private enum Keys {
        static let appTheme = "appTheme"
        static let appLanguage = "appLanguage"
        static let isFirstVisit = "isFirstVisit"
    }
    
    var appTheme: AppTheme {
        get {
            guard let rawValue = storage.string(forKey: Keys.appTheme),
                  let theme = AppTheme(rawValue: rawValue) else {
                return .light
            }
            return theme
        }
        set {
            storage.set(newValue.rawValue, forKey: Keys.appTheme)
        }
    }
    
    var appLanguage: AppLanguage {
        get {
            guard let rawValue = storage.string(forKey: Keys.appLanguage),
                  let language = AppLanguage(rawValue: rawValue) else {
                return .base
            }
            return language
        }
        set {
            storage.set(newValue.rawValue, forKey: Keys.appLanguage)
        }
    }
    
    var isFirstVisit: Bool {
        get {
            if storage.object(forKey: Keys.isFirstVisit) == nil {
                return true
            }
            return storage.bool(forKey: Keys.isFirstVisit)
        }
        set {
            storage.set(newValue, forKey: Keys.isFirstVisit)
        }
    }
}
