//
//  TeamCell.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 23/05/2026.
//

import UIKit

class TeamCell: UICollectionViewCell {
        // MARK: - Outlets
        @IBOutlet weak var containerView: UIView!
        @IBOutlet weak var teamImageView: UIImageView!
        @IBOutlet weak var teamNameLabel: UILabel!
        @IBOutlet weak var overlayView: UIView!
        
        // MARK: - Awake from Nib
        override func awakeFromNib() {
            super.awakeFromNib()
            setupCellAppearance()
        }
        
        // MARK: - Setup Methods
        private func setupCellAppearance() {
            
        }
        
        // MARK: - Configure Method
        func configure(with team: Team) {
            teamNameLabel.text = team.teamName
            loadImage(from: team.teamLogo ?? "", into: teamImageView)
        }
        
        private func loadImage(from urlString: String, into imageView: UIImageView) {
            if let image = UIImage(named: urlString) {
                imageView.image = image
            } else {
                 imageView.image = UIImage(systemName: "person.circle.fill")
                imageView.tintColor = .systemGray3
                imageView.backgroundColor = .systemGray5
            }
        }
        
        @objc private func cellTapped() {
            
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }) { _ in
                UIView.animate(withDuration: 0.1) {
                    self.transform = .identity
                }
            }
        }
        
        func setSelected(_ selected: Bool, animated: Bool) {
            overlayView.isHidden = !selected
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            teamImageView.image = nil
            teamNameLabel.text = nil
            overlayView.isHidden = true
        }
    }
