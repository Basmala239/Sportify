//
//  SettingPresenter.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 06/06/2026.
//

import Foundation
import UIKit
protocol SettingViewProtocol: AnyObject {
    func updateThemeSelection(to theme: AppTheme)
    func updateLanguageSelection(to language: AppLanguage)
}

class SettingPresenter {
    
    private weak var view: SettingViewProtocol?
    private var storage: AppSettingsStorage
    
    init(view: SettingViewProtocol, storage: AppSettingsStorage = UserDefaultsManager.shared) {
        self.view = view
        self.storage = storage
    }
    
    func viewDidLoad() {
        view?.updateThemeSelection(to: storage.appTheme)
        view?.updateLanguageSelection(to: storage.appLanguage)
    }
    
    func themeChanged(selectedIndex: Int) {
        let selectedTheme: AppTheme = (selectedIndex == 0) ? .light : .dark
        storage.appTheme = selectedTheme
        applyTheme(selectedTheme)
    }
    
    func languageChanged(to language: AppLanguage) {
        storage.appLanguage = language
        applyLanguage(language)
    }
    
    private func applyTheme(_ theme: AppTheme) {
        DispatchQueue.main.async {
            let style: UIUserInterfaceStyle = (theme == .dark) ? .dark : .light
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                windowScene.windows.forEach { window in
                    window.overrideUserInterfaceStyle = style
                }
            }
           
        }
    }
    
    private func applyLanguage(_ language: AppLanguage) {
        let languageCode: String
                switch language {
                case .arabic:
                    languageCode = "ar"
                case .english:
                    languageCode = "en"
                }
                
                LanguageManager.shared.setLanguage(languageCode: languageCode)
    }
}
