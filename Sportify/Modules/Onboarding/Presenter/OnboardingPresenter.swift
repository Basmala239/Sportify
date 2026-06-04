//
//  OnboardingPresenter.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 02/06/2026.
//

import Foundation

protocol OnboardingViewProtocol: AnyObject {
    func updateUI(withIndex index: Int, totalPages: Int, buttonTitle: String)
    func navigateToPage(at index: Int, directionForward: Bool)
    func navigateToHome()
}

class OnboardingPresenter {
    private weak var view: OnboardingViewProtocol?
    private let steps: [OnboardingStep]
    private(set) var currentIndex: Int = 0
    private var storage: OnboardingStorage
    
    var totalStepsCount: Int {
        return steps.count
    }
    
     init(view: OnboardingViewProtocol, storage: OnboardingStorage = UserDefaultsManager.shared) {
        self.view = view
        self.storage = storage
        self.steps = [
            OnboardingStep(imageName: "onboarding1", title: "Welcome to SportsHub", description: "Your ultimate destination for live scores, stats, and highlights."),
            OnboardingStep(imageName: "onboarding2", title: "Never Miss a Moment", description: "Get real-time updates and notifications for your favorite teams."),
            OnboardingStep(imageName: "onboarding3", title: "Stay in the Game", description: "Track player stats, league standings, and deep analytics easily.")
        ]
    }
    
    func loadInitialState() {
        updateView()
    }
    
    func getStep(at index: Int) -> OnboardingStep? {
        guard index >= 0 && index < steps.count else { return nil }
        return steps[index]
    }
    
    func handleNextTapped() {
        if currentIndex < steps.count - 1 {
            currentIndex += 1
            updateView()
            view?.navigateToPage(at: currentIndex, directionForward: true)
        } else {
            storage.isFirstVisit = false
            view?.navigateToHome()
        }
    }
    
    func handlePageSwiped(to index: Int) {
        guard index >= 0 && index < steps.count else { return }
        _ = index > currentIndex
        currentIndex = index
        updateView()
    }
    
    private func updateView() {
        let buttonTitle = (currentIndex == steps.count - 1) ? "Get Started" : "Next"
        view?.updateUI(withIndex: currentIndex, totalPages: steps.count, buttonTitle: buttonTitle)
    }
}
