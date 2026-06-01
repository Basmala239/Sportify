//
//  TeamHeaderView.swift
//  Sportify
//
//  Created by Esraa Ehab on 30/05/2026.
//

import UIKit

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
            cardView.layer.shadowColor = UIColor.cyan.cgColor
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
}
