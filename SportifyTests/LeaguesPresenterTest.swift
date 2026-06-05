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
            League(leagueKey: "1", leagueName: "EPL", countryName: "England"),
            League(leagueKey: "2", leagueName: "Serie A", countryName: "Italy")
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
    
    func test_fetchData_whenResponseIsEmpty_shouldRenderEmptyArray() async {
        mockNetwork.isConnected = true
        mockNetwork.mockResponse = LeagueResponse(success: 1, result: [])
        
        presenter.fetchData(for: APIEndpoints.football)
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        XCTAssertTrue(mockView.isStartLoadingCalled)
        XCTAssertTrue(mockView.isStopLoadingCalled)
        XCTAssertNotNil(mockView.renderedLeagues)
        XCTAssertEqual(mockView.renderedLeagues?.count, 0, "Should render empty array when no leagues returned")
    }

    // MARK: - 3. Filter Leagues Tests

    func test_filterLeagues_withEmptySearchText_shouldShowAllLeagues() {
        // Given
        let allLeagues = [
            League(leagueKey: "1", leagueName: "Premier League"),
            League(leagueKey: "2", leagueName: "La Liga"),
            League(leagueKey: "3", leagueName: "Bundesliga")
        ]
        presenter.attachView(mockView)
        
        // Manually set leagues through fetch (simulating successful fetch)
        mockNetwork.isConnected = true
        mockNetwork.mockResponse = LeagueResponse(success: 1, result: allLeagues)
        
        let expectation = XCTestExpectation(description: "Fetch leagues")
        presenter.fetchData(for: APIEndpoints.football)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            // When
            self.presenter.filterLeagues(with: "")
            
            // Then
            XCTAssertEqual(self.mockView.renderedLeagues?.count, 3)
            XCTAssertEqual(self.mockView.renderedLeagues?.first?.leagueName, "Premier League")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_filterLeagues_withMatchingSearchText_shouldShowFilteredLeagues() {
        // Given
        let allLeagues = [
            League(leagueKey: "1", leagueName: "Premier League"),
            League(leagueKey: "2", leagueName: "La Liga"),
            League(leagueKey: "3", leagueName: "Ligue 1")
        ]
        mockNetwork.isConnected = true
        mockNetwork.mockResponse = LeagueResponse(success: 1, result: allLeagues)
        
        let expectation = XCTestExpectation(description: "Fetch and filter leagues")
        presenter.fetchData(for: APIEndpoints.football)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            // When
            self.presenter.filterLeagues(with: "Lig")
            
            // Then
            XCTAssertEqual(self.mockView.renderedLeagues?.count, 2)
            XCTAssertTrue(self.mockView.renderedLeagues?.contains(where: { $0.leagueName == "La Liga" }) ?? false)
            XCTAssertTrue(self.mockView.renderedLeagues?.contains(where: { $0.leagueName == "Ligue 1" }) ?? false)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_filterLeagues_withNonMatchingSearchText_shouldShowEmptyArray() {
        // Given
        let allLeagues = [
            League(leagueKey: "1", leagueName: "Premier League"),
            League(leagueKey: "2", leagueName: "La Liga")
        ]
        mockNetwork.isConnected = true
        mockNetwork.mockResponse = LeagueResponse(success: 1, result: allLeagues)
        
        let expectation = XCTestExpectation(description: "Fetch and filter with no matches")
        presenter.fetchData(for: APIEndpoints.football)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            // When
            self.presenter.filterLeagues(with: "NBA")
            
            // Then
            XCTAssertEqual(self.mockView.renderedLeagues?.count, 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_filterLeagues_withCaseInsensitiveSearch_shouldWorkCorrectly() {
        // Given
        let allLeagues = [
            League(leagueKey: "1", leagueName: "PREMIER LEAGUE"),
            League(leagueKey: "2", leagueName: "premier league"),
            League(leagueKey: "3", leagueName: "La Liga")
        ]
        mockNetwork.isConnected = true
        mockNetwork.mockResponse = LeagueResponse(success: 1, result: allLeagues)
        
        let expectation = XCTestExpectation(description: "Fetch and filter case insensitively")
        presenter.fetchData(for: APIEndpoints.football)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            // When
            self.presenter.filterLeagues(with: "premier")
            
            // Then
            XCTAssertEqual(self.mockView.renderedLeagues?.count, 2)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_filterLeagues_withWhitespace_shouldTreatAsEmpty() {
        // Given
        let allLeagues = [
            League(leagueKey: "1", leagueName: "Premier League"),
            League(leagueKey: "2", leagueName: "La Liga")
        ]
        mockNetwork.isConnected = true
        mockNetwork.mockResponse = LeagueResponse(success: 1, result: allLeagues)
        
        let expectation = XCTestExpectation(description: "Fetch and filter with whitespace")
        presenter.fetchData(for: APIEndpoints.football)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            // When
            self.presenter.filterLeagues(with: "   ")
            
            // Then
            XCTAssertEqual(self.mockView.renderedLeagues?.count, 2, "Whitespace should show all leagues")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

    // MARK: - 4. Presenter Delegation / Routing Tests

    func test_didSelectLeague_shouldTriggerNavigationWithCorrectData() {
        let selectedLeague = League(leagueKey: "55", leagueName: "Wimbledon")
        let targetSport = APIEndpoints.tennis
        
        presenter.didSelectLeague(selectedLeague, sportEndpoint: targetSport)
        
        XCTAssertEqual(mockView.navigatedSportEndpoint, APIEndpoints.tennis, "Should pass accurate endpoint directory structure")
        XCTAssertEqual(mockView.navigatedLeague?.leagueKey, "55")
        XCTAssertEqual(mockView.navigatedLeague?.leagueName, "Wimbledon")
    }
    
    func test_didSelectLeague_withDifferentSports_shouldPassCorrectEndpoint() {
        let selectedLeague = League(leagueKey: "100", leagueName: "NBA")
        
        // Test football
        presenter.didSelectLeague(selectedLeague, sportEndpoint: APIEndpoints.football)
        XCTAssertEqual(mockView.navigatedSportEndpoint, APIEndpoints.football)
        
        // Test basketball
        presenter.didSelectLeague(selectedLeague, sportEndpoint: APIEndpoints.basketball)
        XCTAssertEqual(mockView.navigatedSportEndpoint, APIEndpoints.basketball)
        
        // Test tennis
        presenter.didSelectLeague(selectedLeague, sportEndpoint: APIEndpoints.tennis)
        XCTAssertEqual(mockView.navigatedSportEndpoint, APIEndpoints.tennis)
    }

    // MARK: - 5. View Attachment Test
    
    func test_attachView_shouldSetViewReference() {
        // Given
        let newMockView = MockLeaguesView()
        
        // When
        presenter.attachView(newMockView)
        
        // Then
        // We can test this by calling a method that uses the view
        presenter.filterLeagues(with: "test")
        XCTAssertTrue(newMockView.isRenderLeagueCalled, "New view should receive updates")
    }
    
    // MARK: - 6. Multiple Filter Tests
    
    func test_multipleFilters_shouldWorkSequentially() {
        // Given
        let allLeagues = [
            League(leagueKey: "1", leagueName: "Premier League"),
            League(leagueKey: "2", leagueName: "La Liga"),
            League(leagueKey: "3", leagueName: "Ligue 1"),
            League(leagueKey: "4", leagueName: "Serie A")
        ]
        mockNetwork.isConnected = true
        mockNetwork.mockResponse = LeagueResponse(success: 1, result: allLeagues)
        
        let expectation = XCTestExpectation(description: "Multiple filters")
        presenter.fetchData(for: APIEndpoints.football)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            // When - First filter
            self.presenter.filterLeagues(with: "L")
            XCTAssertEqual(self.mockView.renderedLeagues?.count, 3)
            
            // When - Second filter (narrow down)
            self.presenter.filterLeagues(with: "La")
            XCTAssertEqual(self.mockView.renderedLeagues?.count, 1)
            XCTAssertEqual(self.mockView.renderedLeagues?.first?.leagueName, "La Liga")
            
            // When - Clear filter
            self.presenter.filterLeagues(with: "")
            XCTAssertEqual(self.mockView.renderedLeagues?.count, 4)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
