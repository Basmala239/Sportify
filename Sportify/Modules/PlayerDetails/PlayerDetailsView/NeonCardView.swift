//
//  NeonCardView.swift
//  Sportify
//
//  Created by Esraa Ehab on 05/06/2026.
//

import UIKit

class NeonCardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDesign()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDesign()
    }
    
    private func setupDesign() {
        self.backgroundColor = .appSecondary
        self.layer.borderColor = UIColor.appPrimary.cgColor
        self.layer.borderWidth = 1.5
        self.layer.cornerRadius = 12
        self.clipsToBounds = false
        
        self.layer.shadowColor = UIColor.appPrimary.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 6
    }
}
