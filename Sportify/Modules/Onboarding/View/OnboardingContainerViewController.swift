//
//  OnboardingContainerViewController.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 02/06/2026.
//

import UIKit

class OnboardingContainerViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - Properties
    private var pageViewController: UIPageViewController!
    private var gradientLayer: CAGradientLayer?
    private var presenter: OnboardingPresenter!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = OnboardingPresenter(view: self)
        
        setupPageViewController()
        setupPageControlLayout()
        presenter.loadInitialState()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyButtonGradient()
    }
    
    // MARK: - UI Setups
    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        if let firstVC = createPageViewController(at: 0) {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
        }
        
        addChild(pageViewController)
        pageViewController.view.frame = containerView.bounds
        containerView.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
    
    private func setupPageControlLayout() {
        pageControl.isUserInteractionEnabled = false
    }
    
    private func applyButtonGradient() {
        gradientLayer?.removeFromSuperlayer()
        
        let gradient = CAGradientLayer()
        gradient.frame = nextButton.bounds
        gradient.colors = [
            UIColor(red: 45/255, green: 85/255, blue: 240/255, alpha: 1.0).cgColor,
            UIColor(red: 0/255, green: 220/255, blue: 255/255, alpha: 1.0).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.cornerRadius = nextButton.frame.size.height / 2
        
        nextButton.layer.insertSublayer(gradient, at: 0)
        nextButton.clipsToBounds = true
        nextButton.setTitleColor(.white, for: .normal)
        gradientLayer = gradient
    }
    
    private func createPageViewController(at index: Int) -> OnboardingDataViewController? {
        guard let stepData = presenter.getStep(at: index) else { return nil }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let dataVC = storyboard.instantiateViewController(withIdentifier: "OnboardingDataViewController") as? OnboardingDataViewController {
            dataVC.stepData = stepData
            dataVC.pageIndex = index
            return dataVC
        }
        return nil
    }
    
    // MARK: - IBActions
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        presenter.handleNextTapped()
    }
}

// MARK: - OnboardingViewProtocol Implementation
extension OnboardingContainerViewController: OnboardingViewProtocol {
    
    func updateUI(withIndex index: Int, totalPages: Int, buttonTitle: String) {
        pageControl.numberOfPages = totalPages
        pageControl.currentPage = index
        nextButton.setTitle(buttonTitle, for: .normal)
    }
    
    func navigateToPage(at index: Int, directionForward: Bool) {
        if let nextVC = createPageViewController(at: index) {
            let direction: UIPageViewController.NavigationDirection = directionForward ? .forward : .reverse
            pageViewController.setViewControllers([nextVC], direction: direction, animated: true, completion: nil)
        }
    }
    
    func navigateToHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainRootVC = storyboard.instantiateViewController(withIdentifier: "HomeNavigationWrapper")
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = mainRootVC
            UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve, animations: nil)
        }
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? OnboardingDataViewController else { return nil }
        return createPageViewController(at: currentVC.pageIndex - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? OnboardingDataViewController else { return nil }
        return createPageViewController(at: currentVC.pageIndex + 1)
    }
}

// MARK: - UIPageViewControllerDelegate
extension OnboardingContainerViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed,
           let currentVC = pageViewController.viewControllers?.first as? OnboardingDataViewController {
            presenter.handlePageSwiped(to: currentVC.pageIndex)
        }
    }
}
