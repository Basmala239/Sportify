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
            // Container styling
            containerView.layer.cornerRadius = 12
            containerView.layer.shadowColor = UIColor.black.cgColor
            containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
            containerView.layer.shadowRadius = 4
            containerView.layer.shadowOpacity = 0.1
            containerView.backgroundColor = .systemBackground
            
            // Circular image view
            teamImageView.layer.cornerRadius = 45 // Half of width (90/2)
            teamImageView.clipsToBounds = true
            teamImageView.contentMode = .scaleAspectFit
            teamImageView.backgroundColor = .systemGray6
            teamImageView.layer.borderWidth = 2
            teamImageView.layer.borderColor = UIColor.systemOrange.cgColor
            
            // Team name label
            teamNameLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            teamNameLabel.textColor = .label
            teamNameLabel.textAlignment = .center
            teamNameLabel.numberOfLines = 2
            
            // Overlay view (for selection effect)
            overlayView.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.3)
            overlayView.layer.cornerRadius = 12
            overlayView.isHidden = true
            
            // Add tap animation
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
            self.addGestureRecognizer(tapGesture)
        }
        
        // MARK: - Configure Method
        func configure(with team: Team) {
            teamNameLabel.text = team.name
            loadImage(from: team.logo, into: teamImageView)
        }
        
        private func loadImage(from urlString: String, into imageView: UIImageView) {
            if let image = UIImage(named: urlString) {
                imageView.image = image
            } else {
                // Use placeholder with team name initial
                imageView.image = UIImage(systemName: "person.circle.fill")
                imageView.tintColor = .systemGray3
                imageView.backgroundColor = .systemGray5
            }
        }
        
        @objc private func cellTapped() {
            // Animate cell tap
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
