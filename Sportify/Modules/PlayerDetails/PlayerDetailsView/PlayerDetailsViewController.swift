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
    
    var playerDetails: PlayerDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderUI()
        populateHeaderData()
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
   
}
