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
    override func awakeFromNib() {
        super.awakeFromNib()
        
        leaguesView.layer.cornerRadius = 24
        leaguesView.layer.masksToBounds = true
        leaguesView.layer.borderWidth = 1
        leaguesView.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
                
        leaguesImage.layer.cornerRadius = leaguesImage.frame.size.width / 2
        leaguesImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func configure(with favorite: Favorite) {
            leaguesTitle.text = favorite.name
            leaguesCountry.text = "Football"
        leaguesImage.image = UIImage(named: favorite.image ?? "star.fill")
        }
    
}
