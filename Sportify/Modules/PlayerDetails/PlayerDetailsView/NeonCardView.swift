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
        self.backgroundColor = UIColor(red: 13/255, green: 24/255, blue: 40/255, alpha: 1.0)
        self.layer.borderColor = UIColor.cyan.cgColor
        self.layer.borderWidth = 1.5
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
    }
}
