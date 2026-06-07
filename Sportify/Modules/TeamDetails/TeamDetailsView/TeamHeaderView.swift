//
//  TeamHeaderView.swift
//  Sportify
//
//  Created by Esraa Ehab on 30/05/2026.
//

import UIKit
import SDWebImage

class TeamHeaderView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var teamLogoImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var coachNameLabel: UILabel!
    @IBOutlet weak var playersCountLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(String(describing: TeamHeaderView.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        setupCardDesign()
        setStaticData()
    }
    private func setupCardDesign() {
            cardView.layer.cornerRadius = 16
            cardView.layer.shadowColor = UIColor.appPrimary.cgColor
            cardView.layer.shadowOpacity = 0.2
            cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
            cardView.layer.shadowRadius = 8
            cardView.layer.masksToBounds = false
            teamLogoImageView.layer.cornerRadius = 8
            teamLogoImageView.clipsToBounds = true
        }
    
    private func setStaticData() {
            teamNameLabel.text = "Liverpool"
            coachNameLabel.text = "Coach: Arne Slot"
            playersCountLabel.text = "Players: 31"
            teamLogoImageView.image = UIImage(named: "team_logo")
        }
    func configure(with team: Team) {
                teamNameLabel.text = team.teamName
                
                if let coach = team.coaches?.first {
                    coachNameLabel.isHidden = false
                    coachNameLabel.text = String(format: "coach name".localized, coach.coachName ?? "unknown".localized)
                } else {
                    coachNameLabel.isHidden = true 
                }
                
                let count = team.players?.count ?? 0
        playersCountLabel.text = String(format: "players_count_text".localized, count)
                
                if let logoString = team.teamLogo, let logoUrl = URL(string: logoString) {
                    teamLogoImageView.sd_setImage(with: logoUrl, placeholderImage: UIImage(named: "team_logo"))
                } else {
                    teamLogoImageView.image = UIImage(named: "team_logo")
                }
            }
}
