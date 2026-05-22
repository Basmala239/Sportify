//
//  SplashViewController.swift
//  Sportify
//
//  Created by Esraa Ehab on 21/05/2026.
//

import Foundation
import UIKit

class SplashViewController : UIViewController , SplashViewProtocol{
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    var presenter : SplashPresenterProtocol!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        titleLabel.text = ""
        progressBar.progress = 0.0
        presenter = SplashPresenter(view: self)
        presenter.viewDidLoad()
    }
    
    func animateTitle(text: String) {
        titleLabel.text = ""
        let delayPerCharacter = 0.2
        var charIndex = 0.0
                
        for letter in text {
             Timer.scheduledTimer(withTimeInterval: delayPerCharacter * charIndex, repeats: false) { _ in
                  self.titleLabel.text?.append(letter)
             }
                charIndex += 1
            }
    }
    
    func fillProgressBar(duration: Double) {
        UIView.animate(withDuration: duration, delay: 0.2, options: .curveEaseInOut, animations: {
                    self.progressBar.setProgress(1.0, animated: true)
                    self.progressBar.layoutIfNeeded()
                }, completion: nil)
    }
    
    func navigateToNextScreen() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let nextVC = mainStoryboard.instantiateViewController(withIdentifier: "HomeTabBar") as? UIViewController {
                    nextVC.modalPresentationStyle = .fullScreen
                    nextVC.modalTransitionStyle = .crossDissolve 
                    self.present(nextVC, animated: true, completion: nil)
                }
            }
}
