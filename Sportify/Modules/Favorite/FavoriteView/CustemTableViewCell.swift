//
//  CustemTableViewCell.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 20/05/2026.
//

import UIKit

class CustemTableViewCell: UITableViewCell {

    @IBOutlet weak var leaguesImage: UIImageView!
    @IBOutlet weak var leaguesTitle: UILabel!
    @IBOutlet weak var leaguesCountry: UILabel!
    @IBOutlet weak var leaguesView: UIView!
    
    @IBOutlet weak var imgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        leaguesView.layer.cornerRadius = 20.0
        leaguesView.clipsToBounds = true
        
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 8.0
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
    }
    override func layoutSubviews() {
        // 1. Force constraints to calculate final sizes immediately
        self.contentView.layoutIfNeeded()
        super.layoutSubviews()
        
        imgView.layer.cornerRadius = imgView.frame.size.width / 2

        // 2. Circular image setup
        leaguesImage.layer.cornerRadius = leaguesImage.frame.size.width / 2
        leaguesImage.clipsToBounds = true
        
        // 3. Draw the neon borders on the finalized view bounds
        let neonCyan = UIColor(red: 0.0/255.0, green: 220.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        leaguesView.addCustomCardBorders(color: neonCyan, thickness: 3.0, radius: 20.0)
    }
    func configure(with favorite: Favorite) {
        leaguesTitle.text = favorite.name
        leaguesCountry.text = "Football"
        leaguesImage.image = UIImage(named: favorite.image ?? "star.fill")
    }
}
