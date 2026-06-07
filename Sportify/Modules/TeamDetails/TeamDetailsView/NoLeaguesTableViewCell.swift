//
//  NoLeaguesTableViewCell.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 07/06/2026.
//

import UIKit

class NoLeaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var noFixtureLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        noFixtureLabel.text = "No Fixture".localized
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
