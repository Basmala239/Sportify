//
//  FavoritePresenter.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 20/05/2026.
//
import Foundation

protocol FavoriteLocalProtocol {
    func fetchAllFavorites() -> [Favorite]
    func deleteFavorite(leagueKey: String) 
    func isFavorite(leagueKey: String) -> Bool
    func addFavorite(leagueKey: String, name: String?, imageString: String?, country: String?, endPoint: String?)
}

class FavoritePresenter {
    
    private weak var view: FavoriteView?
    private var result: [Favorite] = []
    private let networkService: NetworkServiceProtocol
    private let localManager: FavoriteLocalProtocol
        
    init(networkService: NetworkServiceProtocol = NetworkService.shared,localManager: FavoriteLocalProtocol = CoreDataManager.shared) {
        self.networkService = networkService
        self.localManager = localManager
    }
    
    
    func attachView(_ view: FavoriteView) {
        self.view = view
    }
    
    func fetchData() {
        self.result = localManager.fetchAllFavorites()
        
        self.view?.renderFavorite(self.result)
    }
    
    func deleteFavoriteItem(at index: Int) {
        guard index < result.count else { return }
        let itemToDelete = result[index]
        
        if let leagueKey = itemToDelete.leagueKey {
            localManager.deleteFavorite(leagueKey: leagueKey)
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
