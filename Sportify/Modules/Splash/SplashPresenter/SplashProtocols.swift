//
//  SplashProtocols.swift
//  Sportify
//
//  Created by Esraa Ehab on 21/05/2026.
//

import Foundation

protocol SplashViewProtocol:AnyObject{
    func animateTitle(text: String)
    func fillProgressBar(duration: Double)
    func navigateToNextScreen()
    func navigateToOnboarding()
}

protocol SplashPresenterProtocol {
    func viewDidLoad()
}

