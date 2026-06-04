//
//  MockFavoriteView.swift
//  SportifyTests
//
//  Created by Esraa Ehab on 04/06/2026.
//

import Foundation
@testable import Sportify

class MockFavoriteView: FavoriteView {
    var isRenderFavoriteCalled = false
    var renderedFavorites: [Favorite] = []
    
    var isNavigateCalled = false
    var isShowNoConnectionAlertCalled = false
    
    func renderFavorite(_ favorites: [Favorite]) {
        isRenderFavoriteCalled = true
        renderedFavorites = favorites
    }
    
    func navigateToLeagueDetails(with league: Favorite) {
        isNavigateCalled = true
    }
    
    func showNoConnectionAlert() {
        isShowNoConnectionAlertCalled = true
    }
}
