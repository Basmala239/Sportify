//
//  TeamCell.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 23/05/2026.
//

import UIKit

class TeamCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var overlayView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 20.0
        containerView.clipsToBounds = true
        
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 8.0
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded()
        
        teamImageView.layer.cornerRadius = teamImageView.frame.size.width / 2
        overlayView.layer.cornerRadius = overlayView.frame.size.width / 2
        
        let neonCyan = UIColor(red: 0.0/255.0, green: 220.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        containerView.addCustomCardBorders(color: neonCyan, thickness: 3.0, radius: 20.0)
    }
        
    
    func configure(with team: Team) {
        teamNameLabel.text = team.teamName
        loadImage(from: team.teamLogo ?? "", into: teamImageView)
    }
    func configure(with player: PlayerProfile) {
        teamNameLabel.text = player.playerName
        loadImage(from: player.playerLogo ?? "", into: teamImageView)
    }
        
    private func loadImage(from urlString: String?, into imageView: UIImageView) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            if let placeholder = UIImage(systemName: "sportscourt.fill") {
                imageView.image = placeholder
            } else {
                imageView.image = nil
                imageView.backgroundColor = .systemGray5
            }
            imageView.tintColor = .systemGray3
            return
        }
        
        let placeholder = UIImage(systemName: "sportscourt.fill")
        imageView.sd_setImage(with: url, placeholderImage: placeholder) { (image, error, cacheType, url) in
            if error != nil {
                imageView.image = UIImage(systemName: "sportscourt.fill")
                imageView.tintColor = .systemGray3
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        teamNameLabel.text = nil
        teamImageView.image = nil
        teamImageView.sd_cancelCurrentImageLoad()
    }
        
}
