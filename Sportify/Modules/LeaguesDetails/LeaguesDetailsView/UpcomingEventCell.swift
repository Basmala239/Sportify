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
    @IBOutlet weak var eventHomeTeam: UILabel!
    @IBOutlet weak var eventAwayTeam: UILabel!
    @IBOutlet weak var homeTeamLogo: UIImageView!
    @IBOutlet weak var awayTeamLogo: UIImageView!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    
    
    
    // MARK: - Awake from Nib
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellAppearance()
    }
    
    // MARK: - Setup Methods
    private func setupCellAppearance() {
        
        
    }
    
    // MARK: - Configure Method
    func configure(with event: Event) {
        eventHomeTeam.text = event.eventHomeTeam
        eventAwayTeam.text = event.eventAwayTeam
        eventDate.text = formatDate(event.eventDate)
        eventTime.text = event.eventTime
        

        loadImage(from: event.homeTeamLogo, into: homeTeamLogo)
        loadImage(from: event.awayTeamLogo, into: awayTeamLogo)
    }
    
    private func formatDate(_ dateString: String) -> String {
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
        
        if let image = UIImage(named: urlString) {
            imageView.image = image
        } else {
            imageView.image = UIImage(systemName: "sportscourt.fill")
            imageView.tintColor = .systemGray3
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
        
    }
}


