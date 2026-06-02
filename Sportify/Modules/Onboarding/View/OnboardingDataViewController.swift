//
//  OnboardingDataViewController.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 02/06/2026.
//
import UIKit

class OnboardingDataViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var stepData: OnboardingStep?
    var pageIndex: Int = 0
    private var overlayView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        overlayView?.frame = view.bounds
    }
    
    private func setupUI() {
        guard let data = stepData else { return }
        
        backgroundImageView.image = UIImage(named: data.imageName)
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        backgroundImageView.contentMode = .scaleAspectFill
        
        setupDarkOverlay()
    }
    
    private func setupDarkOverlay() {
        overlayView?.removeFromSuperview()
        
        let darkOverlay = UIView()
        darkOverlay.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        backgroundImageView.addSubview(darkOverlay)
        self.overlayView = darkOverlay
    }
}
