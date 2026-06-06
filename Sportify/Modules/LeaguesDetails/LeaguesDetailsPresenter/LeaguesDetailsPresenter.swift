//
//  LeaguesDetailsPresenter.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 22/05/2026.
//

import Foundation
protocol LeaguesDetailspresenterProtocol {
    var upcomingMatches: [SportEvent] { get }
    var latestMatches: [SportEvent] { get }
    var teams: [Team] { get }
    var players: [PlayerProfile] { get }
    var sportType: SportType { get }
    var hasTeamsOrPlayers: Bool { get }
    
    func attachView(_ view: LeaguesDetailsView)
    func fetchLeagueDetails(leagueId: String?, endpoint: String)
    func toggleFavorite(league: League, endpoint: String) -> Bool
    func isFavorite(leagueKey: String) -> Bool
    
}
class LeaguesDetailspresenter: LeaguesDetailspresenterProtocol{
    private let localManager: FavoriteLocalProtocol
    private weak var view: LeaguesDetailsView?
    private let networkService: NetworkServiceProtocol
    
    private(set) var upcomingMatches: [SportEvent] = []
    private(set) var latestMatches: [SportEvent] = []
    private(set) var teams: [Team] = []
    private(set) var players: [PlayerProfile] = []
    private(set) var sportType: SportType = .football
    
    var hasTeamsOrPlayers: Bool {
        return sportType == .tennis ? !players.isEmpty : !teams.isEmpty
    }
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared, localManager: FavoriteLocalProtocol = CoreDataManager.shared ) {
        self.networkService = networkService
        self.localManager = localManager
    }
    
    func attachView(_ view: LeaguesDetailsView) {
        self.view = view
    }
    

    func fetchLeagueDetails(leagueId: String?, endpoint: String) {
        guard let leagueId = leagueId, !leagueId.isEmpty else {
            view?.showError("Invalid league ID")
            return
        }
        
        guard networkService.isInternetConnected() else {
            view?.showNoInternetConnection()
            return
        }
        
        view?.startLoading()
        sportType = getSportType(from: endpoint)
        
        Task { @MainActor in
            do {
                try await fetchAllData(leagueId: leagueId, endpoint: endpoint)
                view?.stopLoading()
                view?.reloadData()
            } catch {
                self.view?.stopLoading()
                view?.showError(error.localizedDescription)
            }
        }
    }
    
    func toggleFavorite(league: League, endpoint: String) -> Bool {
        
        if localManager.isFavorite(leagueKey: league.leagueKey) {
            localManager.deleteFavorite(leagueKey: league.leagueKey)
            return false
        } else {
            localManager.addFavorite(
                leagueKey: league.leagueKey,
                name: league.leagueName,
                imageString: league.leagueLogo ?? "",
                country: league.countryName ?? "",
                endPoint: endpoint
            )
            return true
        }
    }
    
    func isFavorite(leagueKey: String) -> Bool {
        return localManager.isFavorite(leagueKey: leagueKey)
    }
    
    // MARK: - Private Methods
    private func fetchAllData(leagueId: String, endpoint: String) async throws {
        async let upcomingTask = fetchUpcomingMatches(leagueId: leagueId, endpoint: endpoint)
        async let latestTask = fetchLatestMatches(leagueId: leagueId, endpoint: endpoint)
        
        let (upcoming, latest) = try await (upcomingTask, latestTask)
        self.upcomingMatches = upcoming
        self.latestMatches = latest
        
        if sportType == .tennis {
            self.players = try await fetchPlayers(leagueId: leagueId, endpoint: endpoint)
        } else {
            self.teams = try await fetchTeams(leagueId: leagueId, endpoint: endpoint)
        }
    }
    
    private func fetchUpcomingMatches(leagueId: String, endpoint: String) async throws -> [SportEvent] {
        let response: EventsResponse = try await networkService.getData(
            endpoint: endpoint,
            met: "Fixtures",
            parameters: [
                "leagueId": leagueId,
                "from": DateFormate.today(),
                "to": DateFormate.daysAhead(600)
            ]
        )
        
        return transformEvents(response.result ?? [], endpoint: endpoint, isUpcoming: true)
    }
    
    private func fetchLatestMatches(leagueId: String, endpoint: String) async throws -> [SportEvent] {
        let response: EventsResponse = try await networkService.getData(
            endpoint: endpoint,
            met: "Fixtures",
            parameters: [
                "leagueId": leagueId,
                "from": DateFormate.daysAgo(600),
                "to": DateFormate.today()
            ]
        )
        
        return transformEvents(response.result ?? [], endpoint: endpoint, isUpcoming: false)
    }
    
    private func fetchTeams(leagueId: String, endpoint: String) async throws -> [Team] {
        let response: TeamResponse = try await networkService.getData(
            endpoint: endpoint,
            met: "Teams",
            parameters: ["leagueId": leagueId]
        )
        return response.result ?? []
    }
    
    private func fetchPlayers(leagueId: String, endpoint: String) async throws -> [PlayerProfile] {
        let response: PlayerProfileResponse = try await networkService.getData(
            endpoint: endpoint,
            met: "Players",
            parameters: ["leagueId": leagueId]
        )
        return response.result ?? []
    }
    
    private func transformEvents(_ events: [Event], endpoint: String, isUpcoming: Bool) -> [SportEvent] {
        return events.compactMap { event in
            EventFactory.createEvent(from: event, sportEndpoint: endpoint, isUpcoming: isUpcoming)
        }
    }
    
    private func getSportType(from endpoint: String) -> SportType {
        switch endpoint {
        case APIEndpoints.tennis:
            return .tennis
        case APIEndpoints.basketball:
            return .basketball
        case APIEndpoints.cricket:
            return .cricket
        default:
            return .football
        }
    }
}

