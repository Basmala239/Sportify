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

        let languageCode = language.rawValue

        LanguageManager.shared.setLanguage(languageCode: languageCode)

        UIView.appearance().semanticContentAttribute =
            language == .arabic
            ? .forceRightToLeft
            : .forceLeftToRight

        DispatchQueue.main.async { [weak self] in

            let alert = UIAlertController(
                title: "language_change_title".localized,
                message: "language_change_message".localized,
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(
                title: "ok_button".localized,
                style: .default
            ) { _ in
                self?.recreateRootViewController()
            })

            if let vc = self?.view as? UIViewController {
                vc.present(alert, animated: true)
            }
        }
    }

    private func recreateRootViewController() {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let rootVC = storyboard.instantiateViewController(
            withIdentifier: "HomeNavigationWrapper"
        )

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }

        window.rootViewController = rootVC
        window.makeKeyAndVisible()

        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: nil
        )
    }
}
