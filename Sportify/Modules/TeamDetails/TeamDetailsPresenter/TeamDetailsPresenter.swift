//
//  TeamDetailsPresenter.swift
//  Sportify
//
//  Created by Esraa Ehab on 02/06/2026.
//

import Foundation

class TeamDetailsPresenter: TeamDetailsPresenterProtocol {
    
    private weak var view: TeamDetailsViewProtocol?
    private let networkService: NetworkServiceProtocol
    private let teamId: Int
    private let sportEndpoint: String
    
    init(view: TeamDetailsViewProtocol,
         networkService: NetworkServiceProtocol = NetworkService.shared,
         teamId: Int,
         sportEndpoint: String = APIEndpoints.football) {
        
        self.view = view
        self.networkService = networkService
        self.teamId = teamId
        self.sportEndpoint = sportEndpoint
    }
    
    func viewDidLoad() {
        fetchTeamData()
    }
    
    func getTeamId() -> Int {
        return teamId
    }
    
    private func fetchTeamData() {
        guard networkService.isInternetConnected() else {
            view?.showError(message: "No Internet Connection".localized)
            return
        }
        view?.showLoading()
        Task {
            do {
                let teamResponse: TeamResponse = try await networkService.getData(
                    endpoint: sportEndpoint,
                    met: "Teams",
                    parameters: ["teamId": teamId]
                )
                
                let fixturesResponse: EventsResponse = try await networkService.getData(
                    endpoint: sportEndpoint,
                    met: "Fixtures",
                    parameters: [
                        "teamId": teamId,
                        "from": DateFormate.today(),
                        "to": DateFormate.daysAhead(365)
                    ]
                )
                
                DispatchQueue.main.async { [weak self] in
                    self?.view?.hideLoading()
                    
                    if let team = teamResponse.result?.first {
                        self?.view?.displayTeamDetails(team: team)
                    }
                    
                    if let fixtures = fixturesResponse.result {
                        self?.view?.displayFixtures(fixtures: fixtures)
                    }
                }
                
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.view?.hideLoading()
                    self?.view?.showError(message: error.localizedDescription)
                }
            }
        }
    }
}
