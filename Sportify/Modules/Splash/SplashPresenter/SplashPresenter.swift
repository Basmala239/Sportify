//
//  SplashPresenter.swift
//  Sportify
//
//  Created by Esraa Ehab on 21/05/2026.
//

import Foundation

class SplashPresenter : SplashPresenterProtocol{
    weak var view : SplashViewProtocol?
    
    init(view: SplashViewProtocol? = nil) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.animateTitle(text: "Sportify")
        view?.fillProgressBar(duration: 2.0)
        DispatchQueue.main.asyncAfter(deadline: .now()+2.5) { [weak self] in 
            self?.view?.navigateToNextScreen()
        }
    }
}
