//
//  PlayerCollectionViewCell.swift
//  Sportify
//
//  Created by Esraa Ehab on 31/05/2026.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerCardView: UIView!
        @IBOutlet weak var playerImageView: UIImageView!
        @IBOutlet weak var playerNameLabel: UILabel!
        @IBOutlet weak var positionLabel: UILabel!
        @IBOutlet weak var ageLabel: UILabel!
        @IBOutlet weak var shirtNumberContainerView: UIView!
        @IBOutlet weak var shirtNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDesign()
        setStaticData()
        // Initialization code
    }
    
    func setupDesign(){
        containerCardView.layer.cornerRadius = 12
        containerCardView.layer.masksToBounds = false
//        containerCardView.layer.borderWidth = 1
//        containerCardView.layer.borderColor = UIColor.cyan.cgColor
//        
        containerCardView.layer.shadowColor = UIColor.cyan.cgColor
        containerCardView.layer.shadowOpacity = 0.3
        containerCardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        containerCardView.layer.shadowRadius = 6
        
        shirtNumberContainerView.layer.cornerRadius = shirtNumberContainerView.frame.height / 2
        shirtNumberContainerView.clipsToBounds = true
        
        self.clipsToBounds = false
        self.contentView.clipsToBounds = false
        containerCardView.clipsToBounds = false
        containerCardView.layer.masksToBounds = false
    }
    
    private func setStaticData() {
            playerNameLabel.text = "Alisson"
            positionLabel.text = "Goalkeeper"
            ageLabel.text = "Age 33"
            shirtNumberLabel.text = "1"
            playerImageView.image = UIImage(named: "person")
        }
}
