//
//  LeaguesTableViewExtension.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 21/05/2026.
//

import Foundation
import UIKit

extension LeaguesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "leagues", for: indexPath) as? CustemTableViewCell else {
            return UITableViewCell()
        }
        
        let targetLeague = leagues[indexPath.row]
        
        cell.textLabel?.text = targetLeague.leagueName
        
        if let logoString = targetLeague.leagueLogo, let logoURL = URL(string: logoString) {
            // cell.yourImageView.kf.setImage(with: logoURL) // Example implementation
        } else {
            // cell.yourImageView.image = UIImage(named: "placeholder_sport")
        }
             
        return cell
    }
}

