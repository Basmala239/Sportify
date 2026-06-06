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
    
    var playerDetails: PlayerDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderUI()
        populateHeaderData()
        populatePhysicalStats()
        populateSeasonStats()
        // Do any additional setup after loading the view.
    }
    
    private func setupHeaderUI() {
            playerImageView.layer.cornerRadius = playerImageView.frame.width / 2
            playerImageView.clipsToBounds = true
            
            playerImageView.layer.borderColor = UIColor.cyan.cgColor
            playerImageView.layer.borderWidth = 2.0
        }
    
    private func populateHeaderData() {
            guard let player = playerDetails else { return }
            playerNameLabel.text = player.playerName?.uppercased()
            let position = player.playerType?.uppercased() ?? "UNKNOWN"
            let team = player.teamName?.uppercased() ?? "UNKNOWN TEAM"
            playerTeamAndPositionLabel.text = "\(position) | \(team)"
            
            if let imageString = player.playerImage, let imageUrl = URL(string: imageString) {
                playerImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "person"))
            } else {
                playerImageView.image = UIImage(named: "person")
            }
           
        }
   
    private func populatePhysicalStats() {
            guard let player = playerDetails else { return }
            
            if let age = player.playerAge {
                ageLabel.text = "\(age) YRS"
            } else {
                ageLabel.text = "N/A"
            }
          
        }
    
    private func populateSeasonStats() {
            guard let player = playerDetails else { return }
            
            goalsLabel.text = player.playerGoals ?? "0"
            assistsLabel.text = player.playerAssists ?? "0"
            matchesLabel.text = player.playerMatchPlayed ?? "0"
            let yellowCards = player.playerYellowCards ?? "0"
            let redCards = player.playerRedCards ?? "0"
            cardsLabel.text = "\(yellowCards) / \(redCards)"
        }
}
