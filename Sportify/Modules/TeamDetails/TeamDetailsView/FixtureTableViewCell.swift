//
//  FixtureTableViewCell.swift
//  Sportify
//
//  Created by Esraa Ehab on 01/06/2026.
//

import UIKit
import SDWebImage

class FixtureTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerCardView: UIView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var homeTeamLogo: UIImageView!
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamLogo: UIImageView!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    @IBOutlet weak var matchTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDesign()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupDesign(){
        selectionStyle = .none
        containerCardView.layer.cornerRadius = 12
        containerCardView.layer.masksToBounds = false
        containerCardView.layer.shadowColor = UIColor.cyan.cgColor
        containerCardView.layer.shadowOpacity = 0.3
        containerCardView.layer.shadowOffset = .zero
        containerCardView.layer.shadowRadius = 6
    }
    
        func configure(with event: Event) {
            leagueNameLabel.text = event.leagueName
            homeTeamNameLabel.text = event.HomeTeamName
            awayTeamNameLabel.text = event.AwayTeamName
            matchTimeLabel.text = "\(event.eventDate ?? "") | \(event.eventTime ?? "")"
            
            if let homeLogoString = event.homeTeamLogo, let homeLogoUrl = URL(string: homeLogoString) {
                        homeTeamLogo.sd_setImage(with: homeLogoUrl, placeholderImage: UIImage(named: "team_logo"))
                    } else {
                        homeTeamLogo.image = UIImage(named: "team_logo")
                    }
                    
                    if let awayLogoString = event.awayTeamLogo, let awayLogoUrl = URL(string: awayLogoString) {
                        awayTeamLogo.sd_setImage(with: awayLogoUrl, placeholderImage: UIImage(named: "team_logo"))
                    } else {
                        awayTeamLogo.image = UIImage(named: "team_logo")
                    }
        }
}
