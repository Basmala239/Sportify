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
        
        let currentLeague = leagues[indexPath.row]
        cell.configure(with: currentLeague)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
        let currentSport = self.sportEndpoint ?? APIEndpoints.football
        presenter.didSelectLeague(leagues[indexPath.row], sportEndpoint: currentSport)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

