//
//  LeaguesPresenter.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 21/05/2026.
//

import Foundation

protocol LeaguesPresenterProtocol {
    func attachView(_ view: LeaguesView)
    func fetchData(for sportEndpoint: String)
    func filterLeagues(with searchText: String)
    func didSelectLeague(_ league: League, sportEndpoint: String)
}

class LeaguesPresenter: LeaguesPresenterProtocol {
    private var allLeagues: [League] = []
    private var filteredLeagues: [League] = []
    private weak var view: LeaguesView?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func attachView(_ view: LeaguesView) {
        self.view = view
    }
    
    func fetchData(for sportEndpoint: String) {
        guard networkService.isInternetConnected() else {
            view?.noConnectionViewVisibility()
            return
        }
        
        view?.startLoading()
        Task { @MainActor in
            do {
                let response: LeagueResponse = try await networkService.getData(
                    endpoint: sportEndpoint,
                    met: "Leagues",
                    parameters: nil
                )
                
                self.view?.stopLoading()
                self.allLeagues = response.result ?? []
                self.filteredLeagues = self.allLeagues
                self.view?.renderLeague(self.filteredLeagues)
            } catch {
                self.view?.stopLoading()
                self.view?.showError(error.localizedDescription)
                print("Error loading leagues: \(error.localizedDescription)")
            }
        }
    }
    
    func filterLeagues(with searchText: String) {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            filteredLeagues = allLeagues
        } else {
            filteredLeagues = allLeagues.filter { league in
                league.leagueName.lowercased().contains(searchText.lowercased())
            }
        }
        view?.renderLeague(filteredLeagues)
    }
    
    func didSelectLeague(_ league: League, sportEndpoint: String) {
        view?.navigateToDetails(sportEndpoint: sportEndpoint, league: league)
    }
}
