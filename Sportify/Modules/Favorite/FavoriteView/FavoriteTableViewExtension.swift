//
//  FavoriteTableView.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 20/05/2026.
//

import Foundation
import UIKit

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return favorites.count
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "leagues", for: indexPath) as? CustemTableViewCell else {
            return UITableViewCell()
        }
        
//        let targetFavoriteItem = favorites[indexPath.row]
//        cell.configure(with: targetFavoriteItem)
        
        return cell
    }
}
