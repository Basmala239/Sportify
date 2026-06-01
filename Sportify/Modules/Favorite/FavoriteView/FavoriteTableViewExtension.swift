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
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "leagues", for: indexPath) as? CustemTableViewCell else {
            return UITableViewCell()
        }
        
        let targetFavoriteItem = favorites[indexPath.row]
        cell.configure(with: targetFavoriteItem)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            
            let itemName = self.favorites[indexPath.row].name ?? "this league"
            
            let alert = UIAlertController(
                title: "Delete Favorite",
                message: "Are you sure you want to remove \(itemName) from your favorites?",
                preferredStyle: .alert
            )
            
             let okAction = UIAlertAction(title: "OK", style: .destructive) { _ in
                self.presenter.deleteFavoriteItem(at: indexPath.row)
                completionHandler(true)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                completionHandler(false)
            }
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            
             self.present(alert, animated: true, completion: nil)
        }
        
        deleteAction.image = UIImage(systemName: "trash.fill")
        deleteAction.backgroundColor = .systemRed
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
