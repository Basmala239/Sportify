//
//  UpcomingEventCell.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 23/05/2026.
//

import UIKit
import SDWebImage

class UpcomingEventCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var eventHomeTeam: UILabel!
    @IBOutlet weak var homeTeamView: UIView!
    @IBOutlet weak var awayTeamView: UIView!
    @IBOutlet weak var eventAwayTeam: UILabel!
    @IBOutlet weak var homeTeamLogo: UIImageView!
    @IBOutlet weak var awayTeamLogo: UIImageView!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    
    // MARK: - Awake from Nib
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
        
        homeTeamView.layer.cornerRadius = homeTeamView.frame.size.width / 2
        awayTeamView.layer.cornerRadius = awayTeamView.frame.size.width / 2
        
        homeTeamLogo.layer.cornerRadius = homeTeamLogo.frame.size.width / 2
        homeTeamLogo.clipsToBounds = true
        awayTeamLogo.layer.cornerRadius = awayTeamLogo.frame.size.width / 2
        awayTeamLogo.clipsToBounds = true
        
        let shadowRect = contentView.bounds.insetBy(dx: 4, dy: 2)
        contentView.layer.shadowPath = UIBezierPath(roundedRect: shadowRect, cornerRadius: 20.0).cgPath
        containerView.addCustomCardBorders(color: .appPrimary, thickness: 3.0, radius: 20.0)
    }
    func configure(with event: SportEvent) {
            if let teamEvent = event as? TeamSportEvent {
                configureTeamEvent(teamEvent)
            } else if let tennisEvent = event as? TennisEvent {
                configureTennisEvent(tennisEvent)
            }
        }
    
    // MARK: - Configure Method
    private func configureTeamEvent(_ event: TeamSportEvent) {
        eventHomeTeam.text = event.homeTeam
        eventAwayTeam.text = event.awayTeam
        eventDate.text = DateFormate.formatDate(event.date)
        eventTime.text = event.time.isEmpty ? "TBD" : event.time
        
        loadImage(from: event.homeTeamLogo, into: homeTeamLogo)
        loadImage(from: event.awayTeamLogo, into: awayTeamLogo)
    }
    
    private func configureTennisEvent(_ event: TennisEvent) {
        eventHomeTeam.text = event.firstPlayer
        eventAwayTeam.text = event.secondPlayer
        eventDate.text = DateFormate.formatDate(event.date)
        eventTime.text = event.time.isEmpty ? "TBD" : event.time
        
        loadImage(from: event.firstPlayerLogo, into: homeTeamLogo)
        loadImage(from: event.secondPlayerLogo, into: awayTeamLogo)
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
        imageView.sd_setImage(with: url, placeholderImage: placeholder) {(image, error, cacheType, url) in
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
