//
//  LeaguesTableViewExtension.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 21/05/2026.
//

import Foundation
import UIKit
import SDWebImage
extension LeaguesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "leagues", for: indexPath) as? CustemTableViewCell else {
            return UITableViewCell()
        }
        
        let targetLeague = leagues[indexPath.row]
        
        cell.leaguesTitle.text = targetLeague.leagueName
        
        cell.leaguesCountry.text = targetLeague.countryName
        
        if let imageUrlString = targetLeague.leagueLogo, let url = URL(string: imageUrlString) {
            cell.leaguesImage.sd_setImage(with: url, placeholderImage: UIImage(named: "star.fill"))
        } else {
            cell.leaguesImage.image = UIImage(named: "star.fill")
        }
             
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        
            let currentSport = self.sportEndpoint ?? APIEndpoints.football
            presenter.didSelectLeague(at: indexPath.row, sportEndpoint: currentSport)
        }
}

