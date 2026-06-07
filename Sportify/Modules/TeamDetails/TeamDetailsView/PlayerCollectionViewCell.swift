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
    
    var rowPlayers: [Player] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDesign()
        // Initialization code
    }
    
    func setupDesign(){
        containerCardView.layer.cornerRadius = 12
        containerCardView.layer.masksToBounds = false
//        containerCardView.layer.borderWidth = 1
//        containerCardView.layer.borderColor = UIColor.cyan.cgColor
//        
        containerCardView.layer.shadowColor = UIColor.appPrimary.cgColor
        containerCardView.layer.shadowOpacity = 0.3
        containerCardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        containerCardView.layer.shadowRadius = 6
        
        shirtNumberContainerView.layer.cornerRadius = shirtNumberContainerView.frame.height / 2
        shirtNumberContainerView.clipsToBounds = true
        
        self.clipsToBounds = false
        self.contentView.clipsToBounds = false
        containerCardView.clipsToBounds = false
        containerCardView.layer.masksToBounds = false
        
        playerImageView.layer.cornerRadius = playerImageView.frame.height / 2
    }
    
    func configure(with player: Player) {
            playerNameLabel.text = player.playerName
        positionLabel.text = player.playerType ?? "Unknown".localized
            
            if let age = player.playerAge {
                ageLabel.text = "Age \(age)"
            } else {
                ageLabel.text = "Age --"
            }
            
            shirtNumberLabel.text = player.playerNumber ?? "-"
            
            if let imageString = player.playerImage, let imageUrl = URL(string: imageString) {
                playerImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "person"))
            } else {
                playerImageView.image = UIImage(named: "person")
            }
        }
}
