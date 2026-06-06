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
        
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4.0
        contentView.layer.shadowOpacity = 0.05
        contentView.layer.masksToBounds = false
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .appBackground
        backgroundView.layer.cornerRadius = 20.0
        self.backgroundView = backgroundView
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded()
        
        teamImageView.layer.cornerRadius = teamImageView.frame.size.width / 2
        overlayView.layer.cornerRadius = overlayView.frame.size.width / 2
        
        let shadowRect = contentView.bounds.insetBy(dx: 4, dy: 2)
        contentView.layer.shadowPath = UIBezierPath(roundedRect: shadowRect, cornerRadius: 20.0).cgPath
        containerView.addCustomCardBorders(color: .appPrimary, thickness: 3.0, radius: 20.0)
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
