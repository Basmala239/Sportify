//
//  LeaguesDetailsPresenter.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 22/05/2026.
//

import Foundation
protocol LeaguesDetailspresenterProtocol {
    func attachView(_ view: LeaguesDetailsView)
    
    
}
class LeaguesDetailspresenter: LeaguesDetailspresenterProtocol{
    private var upcomingMatches: [Event] = []
    private var latestMatches: [Event] = []
    private var teams: [Team] = []
    var sportEndpointName: String?
    var leagueId: String?

    private weak var view: LeaguesDetailsView?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func attachView(_ view: LeaguesDetailsView) {
        self.view = view
    }
    func fetchLeagueDetails() async {
        guard networkService.isInternetConnected() else {
            return
        }
        
        view?.startLoading()
        let endpoint = self.sportEndpointName ?? APIEndpoints.football
        let id = self.leagueId ?? "207"

        if endpoint == APIEndpoints.tennis {
            view?.stopLoading()
            
        }else{
            do {
                let teamsResponse: TeamResponse = try await networkService.getData(
                    endpoint: endpoint,
                    met: "Teams",
                    parameters: ["leagueId": id]
                )
                
                // Fallback safely to empty array if result is nil
                let fetchedTeams = teamsResponse.result ?? []
                print("Successfully decoded \(fetchedTeams.count) teams!")
                
                await view?.renderTeams(fetchedTeams)
                
            } catch {
                print("Decoding Error details: \(error)") // 👈 This prints complete structural mismatch paths if it fails again
            }
        }
    }
}

