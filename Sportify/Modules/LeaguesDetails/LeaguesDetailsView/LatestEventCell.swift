//
//  LatestEventCell.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 23/05/2026.
//

import UIKit

class LatestEventCell: UICollectionViewCell {
 
        // MARK: - Outlets
    @IBOutlet weak var homeTeamView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var awayTeamView: UIView!
    @IBOutlet weak var eventHomeTeam: UILabel!
    @IBOutlet weak var eventAwayTeam: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var homeTeamLogo: UIImageView!
    @IBOutlet weak var awayTeamLogo: UIImageView!
    @IBOutlet weak var matchResult: UILabel!
    
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
        
        homeTeamView.layer.cornerRadius = homeTeamView.frame.size.width / 2
        awayTeamView.layer.cornerRadius = awayTeamView.frame.size.width / 2
        
        homeTeamLogo.layer.cornerRadius = homeTeamLogo.frame.size.width / 2
        homeTeamLogo.clipsToBounds = true
        awayTeamLogo.layer.cornerRadius = awayTeamLogo.frame.size.width / 2
        awayTeamLogo.clipsToBounds = true
        
        let neonCyan = UIColor(red: 0.0/255.0, green: 220.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        containerView.addCustomCardBorders(color: neonCyan, thickness: 3.0, radius: 20.0)
    }
    
    // MARK: - Configure Method
    func configure(with event: Event) {
        var homeScore = event.eventHomeFinalResult ?? "0"
        var awayScore = event.eventAwayFinalResult ?? "0"
        if (homeScore.isEmpty){ homeScore = "0"}
        if (awayScore.isEmpty){ awayScore = "0"}

        let finalResult = "\(homeScore)         \n        \(awayScore)"
        matchResult.text = (event.eventFinalResult ?? finalResult)
        
        eventHomeTeam.text = (event.HomeTeamName ?? event.eventFirstPlayer) ?? "Home Team"
        eventAwayTeam.text = (event.AwayTeamName ?? event.eventSecondPlayer ) ?? "Away Team"
        eventDate.text = DateFormate.formatDate((event.eventDate ?? event.eventDateStart) ?? "Nov 23")
        eventTime.text = event.eventTime ?? "TBD"
        
        loadImage(from: event.homeTeamLogo ?? event.event_home_team_logo ?? event.eventFirstPlayerLogo, into: homeTeamLogo)
        loadImage(from: event.awayTeamLogo ?? event.event_away_team_logo ?? event.eventSecondPlayerLogo , into: awayTeamLogo)
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
        imageView.sd_setImage(with: url, placeholderImage: placeholder) { [weak self] (image, error, cacheType, url) in
            if error != nil {
                imageView.image = UIImage(systemName: "sportscourt.fill")
                imageView.tintColor = .systemGray3
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        eventHomeTeam.text = nil
        eventAwayTeam.text = nil
        eventDate.text = nil
        eventTime.text = nil
        homeTeamLogo.image = nil
        awayTeamLogo.image = nil
        homeTeamLogo.sd_cancelCurrentImageLoad()
        awayTeamLogo.sd_cancelCurrentImageLoad()
    }
}
