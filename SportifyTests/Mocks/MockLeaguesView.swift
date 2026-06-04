//
//  MockLeaguesView.swift
//  SportifyTests
//
//  Created by بسمله ابوزيد احمد on 04/06/2026.
//

import XCTest
@testable import Sportify

class MockLeaguesView: LeaguesView {
    var isStartLoadingCalled = false
    var isStopLoadingCalled = false
    var renderedLeagues: [League]? = nil
    var navigatedSportEndpoint: String? = nil
    var navigatedLeague: League? = nil
    var isNoConnectionVisibleCalled = false

    func startLoading() { isStartLoadingCalled = true }
    func stopLoading() { isStopLoadingCalled = true }
    func renderLeague(_ leagues: [League]) { renderedLeagues = leagues }
    func noConnectionViewVisibility() { isNoConnectionVisibleCalled = true }
    func navigateToDetails(sportEndpoint: String, league: League) {
        navigatedSportEndpoint = sportEndpoint
        navigatedLeague = league
    }
}
