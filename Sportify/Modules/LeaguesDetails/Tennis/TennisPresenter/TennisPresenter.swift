//
//  TennisPresenter.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 03/06/2026.
//

import Foundation
import UIKit
protocol TennispresenterProtocol {
    var upcomingMatches: [TennisEvent] { get }
    var latestMatches: [TennisEvent] { get }
    
    func attachView(_ view: TennisDetailsView)
    func fetchLeagueDetails(_ leagueId: String?) async
}

class TennisPresenter : TennispresenterProtocol {
    private(set) var upcomingMatches: [TennisEvent] = []
    private(set) var latestMatches: [TennisEvent] = []
    var sportEndpointName: String?

    private weak var view: TennisDetailsView?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func attachView(_ view: TennisDetailsView) {
        self.view = view
    }
    func fetchLeagueDetails(_ leagueId: String?) async {
        guard networkService.isInternetConnected() else {
            return
        }
        
        view?.startLoading()
        let endpoint = self.sportEndpointName ?? APIEndpoints.football
        let id = leagueId ?? "207"
        

        if endpoint == APIEndpoints.cricket {
            view?.stopLoading()
            
        }else{
            do {
              let nextResponse: TennisApiResponse = try await networkService.getData(
                   endpoint: endpoint,
                   met: "Fixtures",
                   parameters: [
                       "leagueId": id,
                       "from": DateFormate.today(),
                       "to": DateFormate.daysAhead(600)
                   ]
               )
               
               
               let latestResponse: TennisApiResponse = try await networkService.getData(
                   endpoint: endpoint,
                   met: "Fixtures",
                   parameters: [
                       "leagueId": id,
                       "from": DateFormate.daysAgo(600),
                       "to": DateFormate.today()
                       
                   ]
               )
                
                self.upcomingMatches = nextResponse.result ?? []
                self.latestMatches = latestResponse.result ?? []
                
                print("Next Matches Count: \(upcomingMatches.count)")
                print("Latest Matches Count: \(latestMatches.count)")
                                
                view?.stopLoading()
                view?.reloadData()
                
            } catch {
                print("Decoding Error details: \(error)")
            }
        }
    }
}
