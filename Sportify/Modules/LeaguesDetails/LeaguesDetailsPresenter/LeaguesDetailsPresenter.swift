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
    private var upcomingMatches: [Match] = []
    private var latestMatches: [Match] = []
    private var teams: [Team] = []

    private weak var view: LeaguesDetailsView?
    private let networkService: NetworkServiceProtocol
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func attachView(_ view: LeaguesDetailsView) {
        self.view = view
    }
}
