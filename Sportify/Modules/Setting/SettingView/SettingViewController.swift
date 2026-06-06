//
//  SettingViewController.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 06/06/2026.
//

import UIKit

class SettingViewController: UIViewController, SettingViewProtocol {

    @IBOutlet weak var themeSegment: UISegmentedControl!
    @IBOutlet weak var languageButton: UIButton!
    
    private var presenter: SettingPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = SettingPresenter(view: self)
        setupLanguageMenu()
        presenter.viewDidLoad()
    }
    
    @IBAction func themeSegmentChanged(_ sender: UISegmentedControl) {
        presenter.themeChanged(selectedIndex: sender.selectedSegmentIndex)
    }
    
    func setupLanguageMenu() {
        let englishAction = UIAction(title: "  English (US)", image: nil) { [weak self] _ in
            self?.presenter.languageChanged(to: .english)
        }
        
        let arabicAction = UIAction(title: "  العربية", image: nil) { [weak self] _ in
            self?.presenter.languageChanged(to: .arabic)
        }
        
        let languageMenu = UIMenu(title: "Select Language", children: [englishAction, arabicAction])
        
        languageButton.menu = languageMenu
        languageButton.showsMenuAsPrimaryAction = true
        languageButton.changesSelectionAsPrimaryAction = true
    }
    
    // MARK: - SettingViewProtocol Conformance
    
    func updateThemeSelection(to theme: AppTheme) {
        switch theme {
        case .light:
            themeSegment.selectedSegmentIndex = 0
        case .dark:
            themeSegment.selectedSegmentIndex = 1
        }
    }
    
    func updateLanguageSelection(to language: AppLanguage) {
        guard let menu = languageButton.menu else { return }
        
        for case let action as UIAction in menu.children {
            if language == .english && action.title == "  English (US)" {
                action.state = .on
            } else if language == .arabic && action.title == "  العربية" {
                action.state = .on
            } else {
                action.state = .off
            }
        }
    }
}
