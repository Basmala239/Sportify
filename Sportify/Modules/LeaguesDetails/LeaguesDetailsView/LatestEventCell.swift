//
//  LatestEventCell.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 23/05/2026.
//

import UIKit

class LatestEventCell: UICollectionViewCell {
 
        // MARK: - Outlets
        @IBOutlet weak var containerView: UIView!
        @IBOutlet weak var homeTeamLabel: UILabel!
        @IBOutlet weak var awayTeamLabel: UILabel!
        @IBOutlet weak var homeScoreLabel: UILabel!
        @IBOutlet weak var awayScoreLabel: UILabel!
        @IBOutlet weak var vsScoreLabel: UILabel!
        @IBOutlet weak var dateLabel: UILabel!
        @IBOutlet weak var timeLabel: UILabel!
        @IBOutlet weak var homeTeamImageView: UIImageView!
        @IBOutlet weak var awayTeamImageView: UIImageView!
       // @IBOutlet weak var resultBadge: UIView!
       // @IBOutlet weak var resultLabel: UILabel!
        
        // MARK: - Awake from Nib
        override func awakeFromNib() {
            super.awakeFromNib()
            setupCellAppearance()
        }
        
        // MARK: - Setup Methods
        private func setupCellAppearance() {
            // Container view styling
            containerView.layer.cornerRadius = 12
            containerView.layer.shadowColor = UIColor.black.cgColor
            containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
            containerView.layer.shadowRadius = 4
            containerView.layer.shadowOpacity = 0.1
            containerView.backgroundColor = .systemBackground
            
            // Team labels styling
            homeTeamLabel.font = UIFont.boldSystemFont(ofSize: 16)
            homeTeamLabel.textColor = .label
            homeTeamLabel.textAlignment = .right
            
            awayTeamLabel.font = UIFont.boldSystemFont(ofSize: 16)
            awayTeamLabel.textColor = .label
            awayTeamLabel.textAlignment = .left
            
            // Score labels styling
            homeScoreLabel.font = UIFont.boldSystemFont(ofSize: 20)
            homeScoreLabel.textColor = .systemOrange
            homeScoreLabel.textAlignment = .center
            homeScoreLabel.backgroundColor = .systemGray6
            homeScoreLabel.layer.cornerRadius = 8
            homeScoreLabel.clipsToBounds = true
            
            awayScoreLabel.font = UIFont.boldSystemFont(ofSize: 20)
            awayScoreLabel.textColor = .systemOrange
            awayScoreLabel.textAlignment = .center
            awayScoreLabel.backgroundColor = .systemGray6
            awayScoreLabel.layer.cornerRadius = 8
            awayScoreLabel.clipsToBounds = true
            
            vsScoreLabel.text = ":"
            vsScoreLabel.font = UIFont.boldSystemFont(ofSize: 20)
            vsScoreLabel.textColor = .label
            vsScoreLabel.textAlignment = .center
            
            // Date and time labels
            dateLabel.font = UIFont.systemFont(ofSize: 12)
            dateLabel.textColor = .secondaryLabel
            
            timeLabel.font = UIFont.systemFont(ofSize: 12)
            timeLabel.textColor = .secondaryLabel
            
            // Image views styling
            homeTeamImageView.layer.cornerRadius = 25
            homeTeamImageView.clipsToBounds = true
            homeTeamImageView.contentMode = .scaleAspectFit
            homeTeamImageView.backgroundColor = .systemGray6
            
            awayTeamImageView.layer.cornerRadius = 25
            awayTeamImageView.clipsToBounds = true
            awayTeamImageView.contentMode = .scaleAspectFit
            awayTeamImageView.backgroundColor = .systemGray6
            
            // Result badge
//            resultBadge.layer.cornerRadius = 4
//            resultBadge.clipsToBounds = true
//            resultLabel.font = UIFont.boldSystemFont(ofSize: 10)
//            resultLabel.textColor = .white
//            resultLabel.textAlignment = .center
        }
        
        // MARK: - Configure Method
        func configure(with event: Event) {
            // Extract team names from event name (assuming format "HomeTeam vs AwayTeam")
            let teamComponents = event.eventName.components(separatedBy: " vs ")
            if teamComponents.count == 2 {
                homeTeamLabel.text = teamComponents[0]
                awayTeamLabel.text = teamComponents[1]
            } else {
                homeTeamLabel.text = "Home Team"
                awayTeamLabel.text = "Away Team"
            }
            
            // Set scores
            if let homeScore = event.homeScore, let awayScore = event.awayScore {
                homeScoreLabel.text = "\(homeScore)"
                awayScoreLabel.text = "\(awayScore)"
                determineWinner(homeScore: homeScore, awayScore: awayScore, homeTeam: homeTeamLabel.text ?? "", awayTeam: awayTeamLabel.text ?? "")
            } else {
                homeScoreLabel.text = "-"
                awayScoreLabel.text = "-"
//                resultBadge.isHidden = true
            }
            
            dateLabel.text = formatDate(event.eventDate)
            timeLabel.text = event.eventTime
            
            // Load team images
            loadImage(from: event.homeTeamLogo, into: homeTeamImageView)
            loadImage(from: event.awayTeamLogo, into: awayTeamImageView)
        }
        
        private func determineWinner(homeScore: Int, awayScore: Int, homeTeam: String, awayTeam: String) {
//            resultBadge.isHidden = false
//
//            if homeScore > awayScore {
//                resultLabel.text = "\(homeTeam) WIN"
//                resultBadge.backgroundColor = .systemGreen
//            } else if awayScore > homeScore {
//                resultLabel.text = "\(awayTeam) WIN"
//                resultBadge.backgroundColor = .systemGreen
//            } else {
//                resultLabel.text = "DRAW"
//                resultBadge.backgroundColor = .systemGray
//            }
        }
        
        private func formatDate(_ dateString: String) -> String {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd"
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMM yyyy"
            
            if let date = inputFormatter.date(from: dateString) {
                return outputFormatter.string(from: date)
            }
            return dateString
        }
        
        private func loadImage(from urlString: String, into imageView: UIImageView) {
            if let image = UIImage(named: urlString) {
                imageView.image = image
            } else {
                imageView.image = UIImage(systemName: "sportscourt.fill")
                imageView.tintColor = .systemGray3
            }
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            homeTeamLabel.text = nil
            awayTeamLabel.text = nil
            homeScoreLabel.text = nil
            awayScoreLabel.text = nil
            dateLabel.text = nil
            timeLabel.text = nil
            homeTeamImageView.image = nil
            awayTeamImageView.image = nil
//            resultBadge.isHidden = true
        }
    }
