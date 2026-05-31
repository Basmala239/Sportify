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
    func didSelectLeague(at index: Int, sportEndpoint: String)
}

class LeaguesPresenter: LeaguesPresenterProtocol {
    private var leagues: [League] = []
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
                self.leagues = response.result ?? []
                self.view?.renderLeague(self.leagues)
                
            } catch {
                self.view?.stopLoading()
                print("Error loading leagues: \(error.localizedDescription)")
            }
        }
    }
    func didSelectLeague(at index: Int, sportEndpoint: String){
        guard index < leagues.count else { return }
        
        
        view?.navigateToDetails(sportEndpoint: sportEndpoint, league: leagues[index])
    }
}
