//
//  MockFavoriteLocalManager.swift
//  SportifyTests
//
//  Created by Esraa Ehab on 04/06/2026.
//

import Foundation
@testable import Sportify

class MockFavoriteLocalManager: FavoriteLocalProtocol {
    var stubbedFavorites: [Favorite] = []
    
    var isDeleteCalled = false
    var deletedLeagueKey: String?
    
    var isAddCalled = false
    var addedLeagueKey: String?
    var isCheckFavoriteCalled = false
    
    func fetchAllFavorites() -> [Favorite] {
        return stubbedFavorites
    }
    
    func deleteFavorite(leagueKey: String) {
        isDeleteCalled = true
        deletedLeagueKey = leagueKey
    }
    
    func addFavorite(leagueKey: String, name: String?, imageString: String?, country: String?, endPoint: String?) {
        isAddCalled = true
        addedLeagueKey = leagueKey
    }
    
    func isFavorite(leagueKey: String) -> Bool {
        isCheckFavoriteCalled = true
        return stubbedFavorites.contains { $0.leagueKey == leagueKey }
    }
}
