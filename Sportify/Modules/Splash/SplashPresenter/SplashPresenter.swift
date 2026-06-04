//
//  SplashPresenter.swift
//  Sportify
//
//  Created by Esraa Ehab on 21/05/2026.
//

import Foundation

class SplashPresenter : SplashPresenterProtocol{
    weak var view : SplashViewProtocol?
    private var storage: OnboardingStorage
    
    init(view: SplashViewProtocol? = nil, storage: OnboardingStorage = UserDefaultsManager.shared) {
        self.view = view
        self.storage = storage
    }
    
    func viewDidLoad() {
        view?.animateTitle(text: "Sportify")
        view?.fillProgressBar(duration: 2.0)
        DispatchQueue.main.asyncAfter(deadline: .now()+2.5) { [weak self] in
            guard let self = self else { return }
            
            if self.storage.isFirstVisit {
                self.view?.navigateToOnboarding()
            } else {
                self.view?.navigateToNextScreen()
            }
        }
    }
}
