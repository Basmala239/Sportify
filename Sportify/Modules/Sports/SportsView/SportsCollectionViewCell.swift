//
//  SportsCollectionViewCell.swift
//  Sportify
//
//  Created by Esraa Ehab on 22/05/2026.
//

import UIKit

class SportsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var sportImageView: UIImageView!
    
    @IBOutlet weak var sportLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }
    override var isHighlighted: Bool {
        didSet {
                UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseOut, .beginFromCurrentState, .allowUserInteraction], animations: {
                    self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
                }, completion: nil)
        }
    }
    func configure(with sport: SportItem) {
            sportLabel.text = sport.name
            sportImageView.image = UIImage(named: sport.imageName)
        }

}
