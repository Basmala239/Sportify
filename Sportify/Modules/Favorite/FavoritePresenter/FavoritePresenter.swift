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
    private let networkService: NetworkServiceProtocol
        
        
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    
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
    
    func didSelectFavoriteItem(at index: Int) {
        guard index < result.count else { return }
        
        if networkService.isInternetConnected() {
            let selectedLeague = result[index]
            view?.navigateToLeagueDetails(with: selectedLeague)
        } else {
            view?.showNoConnectionAlert()
        }
    }
}
