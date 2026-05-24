//
//  UpcomingEventCell.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 23/05/2026.
//

import UIKit

class UpcomingEventCell: UICollectionViewCell {

     
        // MARK: - Outlets
        @IBOutlet weak var containerView: UIView!
        @IBOutlet weak var eventNameLabel: UILabel!
        @IBOutlet weak var dateLabel: UILabel!
        @IBOutlet weak var timeLabel: UILabel!
        @IBOutlet weak var homeTeamImageView: UIImageView!
        @IBOutlet weak var awayTeamImageView: UIImageView!
        @IBOutlet weak var vsLabel: UILabel!
        
        // MARK: - Awake from Nib
        override func awakeFromNib() {
            super.awakeFromNib()
            setupCellAppearance()
        }
        
        // MARK: - Setup Methods
        private func setupCellAppearance() {
            // Container view styling
            containerView.layer.cornerRadius = 12
            containerView.frame.size.height = 300
            containerView.layer.shadowColor = UIColor.black.cgColor
            containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
            containerView.layer.shadowRadius = 4
            containerView.layer.shadowOpacity = 0.1
            containerView.backgroundColor = .systemBackground
            
            // Image views styling
            homeTeamImageView.layer.cornerRadius = 30
            homeTeamImageView.clipsToBounds = true
            homeTeamImageView.contentMode = .scaleAspectFit
            homeTeamImageView.backgroundColor = .systemGray6
            
            awayTeamImageView.layer.cornerRadius = 30
            awayTeamImageView.clipsToBounds = true
            awayTeamImageView.contentMode = .scaleAspectFit
            awayTeamImageView.backgroundColor = .systemGray6
            
            // VS Label styling
            vsLabel.text = "VS"
            vsLabel.font = UIFont.boldSystemFont(ofSize: 14)
            vsLabel.textColor = .systemOrange
            vsLabel.textAlignment = .center
            
            // Labels styling
            eventNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
            eventNameLabel.textColor = .label
            eventNameLabel.numberOfLines = 2
            eventNameLabel.textAlignment = .center
            
            dateLabel.font = UIFont.systemFont(ofSize: 12)
            dateLabel.textColor = .secondaryLabel
            
            timeLabel.font = UIFont.systemFont(ofSize: 12)
            timeLabel.textColor = .secondaryLabel
        }
        
        // MARK: - Configure Method
        func configure(with event: Event) {
            eventNameLabel.text = event.eventName
            dateLabel.text = formatDate(event.eventDate)
            timeLabel.text = event.eventTime
            
            // Load team images (replace with your image loading library)
            loadImage(from: event.homeTeamLogo, into: homeTeamImageView)
            loadImage(from: event.awayTeamLogo, into: awayTeamImageView)
        }
        
        private func formatDate(_ dateString: String) -> String {
            // Convert "2024-06-15" to "15 June 2024" or similar format
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd"
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMM dd"
            
            if let date = inputFormatter.date(from: dateString) {
                return outputFormatter.string(from: date)
            }
            return dateString
        }
        
        private func loadImage(from urlString: String, into imageView: UIImageView) {
            // TODO: Replace with SDWebImage or Kingfisher
            // For now, try to load from asset catalog or show placeholder
            if let image = UIImage(named: urlString) {
                imageView.image = image
            } else {
                imageView.image = UIImage(systemName: "sportscourt.fill")
                imageView.tintColor = .systemGray3
            }
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            eventNameLabel.text = nil
            dateLabel.text = nil
            timeLabel.text = nil
            homeTeamImageView.image = nil
            awayTeamImageView.image = nil
        }
    }


