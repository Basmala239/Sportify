//
//  SettingPresenter.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 06/06/2026.
//

import Foundation

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
        
       
    }
    
    private func applyLanguage(_ language: AppLanguage) {
        
       
    }
}
