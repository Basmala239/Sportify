//
//  LeaguesPresenterTest.swift
//  SportifyTests
//
//  Created by بسمله ابوزيد احمد on 04/06/2026.
//

import XCTest
@testable import Sportify

class LeaguesPresenterTest: XCTestCase {

    var presenter: LeaguesPresenter!
    var mockView: MockLeaguesView!
    var mockNetwork: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockView = MockLeaguesView()
        mockNetwork = MockNetworkService()
        presenter = LeaguesPresenter(networkService: mockNetwork)
        presenter.attachView(mockView)
    }

    override func tearDown() {
        presenter = nil
        mockView = nil
        mockNetwork = nil
        super.tearDown()
    }

    // MARK: - 1. Model Parsing Tests

    func test_leagueParsing_whenLeagueKeyIsInt_shouldParseSuccessfullyAndConvertToString() throws {
        let json = """
        {
            "league_key": 123,
            "league_name": "Premier League",
            "country_key": 44
        }
        """.data(using: .utf8)!
        
        let league = try JSONDecoder().decode(League.self, from: json)
        
        XCTAssertEqual(league.leagueKey, "123", "Should successfully convert Int key to String")
        XCTAssertEqual(league.leagueName, "Premier League")
        XCTAssertEqual(league.countryKey, "44", "Should successfully convert Int country key to String")
    }

    func test_leagueParsing_whenLeagueKeyIsString_shouldParseSuccessfully() throws {
        
        let json = """
        {
          "league_key": "789",
          "league_name": "La Liga"
        }
        """.data(using: .utf8)!

        let league = try JSONDecoder().decode(League.self, from: json)

        
        XCTAssertEqual(league.leagueKey, "789")
        XCTAssertEqual(league.leagueName, "La Liga")
    }

    func test_leagueParsing_whenLeagueKeyIsMissing_shouldThrowError() {
        
        let json = """
        {
         "league_name": "Serie A"
        }
        """.data(using: .utf8)!

        XCTAssertThrowsError(try JSONDecoder().decode(League.self, from: json))
    }

    // MARK: - 2. Presenter Logic & Error Handling Tests

    func test_fetchData_whenNoInternet_shouldTriggerNoConnectionView() {
      
        mockNetwork.isConnected = false
        
        presenter.fetchData(for: APIEndpoints.football)
        
        XCTAssertTrue(mockView.isNoConnectionVisibleCalled, "Presenter should tell view to display the offline placeholder")
        XCTAssertFalse(mockView.isStartLoadingCalled, "Presenter should not try loading animation if offline")
    }

    func test_fetchData_whenSuccessfulResponse_shouldRenderLeaguesToView() async {
      
        mockNetwork.isConnected = true
        let expectedLeagues = [
            League(leagueKey: "1", leagueName: "EPL"),
            League(leagueKey: "2", leagueName: "Serie A")
        ]
        mockNetwork.mockResponse = LeagueResponse(success: 1, result: expectedLeagues)

        
        presenter.fetchData(for: APIEndpoints.football)

        
        try? await Task.sleep(nanoseconds: 100_000_000)

        
        XCTAssertTrue(mockView.isStartLoadingCalled)
        XCTAssertTrue(mockView.isStopLoadingCalled)
        XCTAssertNotNil(mockView.renderedLeagues)
        XCTAssertEqual(mockView.renderedLeagues?.count, 2)
        XCTAssertEqual(mockView.renderedLeagues?.first?.leagueName, "EPL")
    }

    func test_fetchData_whenNetworkFails_shouldStopLoadingAndLogError() async {
      
      mockNetwork.isConnected = true
      mockNetwork.shouldReturnError = true

      
      presenter.fetchData(for: APIEndpoints.basketball)
      try? await Task.sleep(nanoseconds: 100_000_000)

      
      XCTAssertTrue(mockView.isStartLoadingCalled)
      XCTAssertTrue(mockView.isStopLoadingCalled, "Loading indicator should stop even if data fetching encounters an error")
      XCTAssertNil(mockView.renderedLeagues, "No leagues should be delivered if backend fails")
    }

    // MARK: - 3. Presenter Delegation / Routing Tests

    func test_didSelectLeague_shouldTriggerNavigationWithCorrectData() {
        let selectedLeague = League(leagueKey: "55", leagueName: "Wimbledon")
        let targetSport = APIEndpoints.tennis
        
        presenter.didSelectLeague(selectedLeague, sportEndpoint: targetSport)
        
        XCTAssertEqual(mockView.navigatedSportEndpoint, "/tennis", "Should pass accurate endpoint directory   structure")
        XCTAssertEqual(mockView.navigatedLeague?.leagueKey, "55")
        XCTAssertEqual(mockView.navigatedLeague?.leagueName, "Wimbledon")
    }

}
