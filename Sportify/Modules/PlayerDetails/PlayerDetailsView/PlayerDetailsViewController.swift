//
//  PlayerDetailsViewController.swift
//  Sportify
//
//  Created by Esraa Ehab on 05/06/2026.
//

import UIKit
import SDWebImage

class PlayerDetailsViewController: UIViewController {

    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerTeamAndPositionLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var goalsLabel: UILabel!
    @IBOutlet weak var assistsLabel: UILabel!
    @IBOutlet weak var matchesLabel: UILabel!
    @IBOutlet weak var cardsLabel: UILabel!
    
    @IBOutlet weak var paceValueLabel: UILabel!
    @IBOutlet weak var shootingValueLabel: UILabel!
    @IBOutlet weak var passingValueLabel: UILabel!
    @IBOutlet weak var dribblingValueLabel: UILabel!
        
    @IBOutlet weak var paceProgressView: UIProgressView!
    @IBOutlet weak var shootingProgressView: UIProgressView!
    @IBOutlet weak var passingProgressView: UIProgressView!
    @IBOutlet weak var dribblingProgressView: UIProgressView!
    
    var player: Player?
    var teamName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderUI()
        populateHeaderData()
        populatePhysicalStats()
        populateSeasonStats()
        populateSkillProfile()
        // Do any additional setup after loading the view.
    }
    
    private func setupHeaderUI() {
            playerImageView.layer.cornerRadius = playerImageView.frame.width / 2
            playerImageView.clipsToBounds = true
            
            playerImageView.layer.borderColor = UIColor.appPrimary.cgColor
            playerImageView.layer.borderWidth = 2.0
        }
    
    private func populateHeaderData() {
        guard let player = player else { return }
                playerNameLabel.text = player.playerName?.uppercased()
                let position = player.playerType?.uppercased() ?? "UNKNOWN"
                let team = teamName?.uppercased() ?? "UNKNOWN TEAM"
                
                playerTeamAndPositionLabel.text = "\(position) | \(team)"
            
            if let imageString = player.playerImage, let imageUrl = URL(string: imageString) {
                playerImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "person"))
            } else {
                playerImageView.image = UIImage(named: "person")
            }
           
        }
   
    private func populatePhysicalStats() {
            guard let player = player else { return }
            
            if let age = player.playerAge {
                ageLabel.text = "\(age)"
            } else {
                ageLabel.text = "26"
            }
          
        }
    
    private func populateSeasonStats() {
            guard let player = player else { return }
            
            let goals = player.playerGoals ?? ""
            goalsLabel.text = goals.isEmpty ? "0" : goals
            assistsLabel.text = player.playerAssists ?? "0"
            matchesLabel.text = player.playerMatchPlayed ?? "0"
            let yellowCards = player.playerYellowCards ?? "0"
            let redCards = player.playerRedCards ?? "0"
            cardsLabel.text = "\(yellowCards) / \(redCards)"
        }
    
    private func populateSkillProfile() {
            guard let player = player else { return }
            
            setupSkillRow(
                valueString: player.playerDuelsWon,
                maxValue: 100,
                valueLabel: paceValueLabel,
                progressView: paceProgressView
            )
            
            setupSkillRow(
                valueString: player.playerShotsTotal,
                maxValue: 150,
                valueLabel: shootingValueLabel,
                progressView: shootingProgressView
            )
            
            setupSkillRow(
                valueString: player.playerPassesAccuracy,
                maxValue: 100,
                valueLabel: passingValueLabel,
                progressView: passingProgressView
            )
            
            setupSkillRow(
                valueString: player.playerDribbleSucc,
                maxValue: 50,
                valueLabel: dribblingValueLabel,
                progressView: dribblingProgressView
            )
        }
        
        private func setupSkillRow(valueString: String?, maxValue: Float, valueLabel: UILabel, progressView: UIProgressView) {
            let rawValue = Float(valueString ?? "0") ?? 0.0
            valueLabel.text = "\(Int(rawValue))"
            let progressPercentage = min(rawValue / maxValue, 1.0)
            
            progressView.setProgress(progressPercentage, animated: true)
        }
}
