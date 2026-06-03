//
//  LeaguesDetailsPresenter.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 22/05/2026.
//

import Foundation
protocol LeaguesDetailspresenterProtocol {
    var upcomingMatches: [Event] { get }
    var latestMatches: [Event] { get }
    var teams: [Team] { get }
    
    func attachView(_ view: LeaguesDetailsView)
    func fetchLeagueDetails(_ leagueId: String?) async
}
class LeaguesDetailspresenter: LeaguesDetailspresenterProtocol{
    private(set) var upcomingMatches: [Event] = []
    private(set) var latestMatches: [Event] = []
    private(set) var teams: [Team] = []
    var sportEndpointName: String?

    private weak var view: LeaguesDetailsView?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func attachView(_ view: LeaguesDetailsView) {
        self.view = view
    }
    func fetchLeagueDetails(_ leagueId: String?) async {
        guard networkService.isInternetConnected() else {
            return
        }
        
        view?.startLoading()
        let endpoint = self.sportEndpointName ?? APIEndpoints.football
        let id = leagueId ?? "207"
        
        do {
           print(DateFormate.today())
           print(DateFormate.daysAhead(7))
           
           let nextResponse: EventsResponse = try await networkService.getData(
               endpoint: endpoint,
               met: "Fixtures",
               parameters: [
                   "leagueId": id,
                   "from": DateFormate.today(),
                   "to": DateFormate.daysAhead(600)
               ]
           )
           
           
           let latestResponse: EventsResponse = try await networkService.getData(
               endpoint: endpoint,
               met: "Fixtures",
               parameters: [
                   "leagueId": id,
                   "from": DateFormate.daysAgo(600),
                   "to": DateFormate.today()
                   
               ]
           )
            
            
            let teamsResponse: TeamResponse = try await networkService.getData(
                endpoint: endpoint,
                met: "Teams",
                parameters: ["leagueId": id]
            )
        
        
            let fetchedTeams = teamsResponse.result ?? []
            print("Successfully decoded \(fetchedTeams.count) teams!")
            self.teams = teamsResponse.result ?? []
            self.upcomingMatches = nextResponse.result ?? []
            self.latestMatches = latestResponse.result ?? []
            
            print("Next Matches Count: \(upcomingMatches.count)")
            print("Latest Matches Count: \(latestMatches.count)")
            print("Latest Matches Count: \(teams.count)")
                            
            view?.stopLoading()
            view?.reloadData()
            
        } catch {
            print("Decoding Error details: \(error)")
        }
    }
}

