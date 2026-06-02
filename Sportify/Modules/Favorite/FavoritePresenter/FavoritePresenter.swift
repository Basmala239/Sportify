//
//  FavoritePresenter.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 20/05/2026.
//
import Foundation

class FavoritePresenter {
    
    private weak var view: FavoriteView?
    private var result: [Favorite] = []
    
    
    
    func attachView(_ view: FavoriteView) {
        self.view = view
    }
    
    func fetchData() {
        self.result = CoreDataManager.shared.fetchAllFavorites()
        
        self.view?.renderFavorite(self.result)
    }
    
    func deleteFavoriteItem(at index: Int) {
        guard index < result.count else { return }
        let itemToDelete = result[index]
        
        if let leagueKey = itemToDelete.leagueKey {
            CoreDataManager.shared.deleteFavorite(leagueKey: leagueKey)
            fetchData()
        }
    }
}
