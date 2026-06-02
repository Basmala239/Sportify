//
//  TeamDetailsProtocol.swift
//  Sportify
//
//  Created by Esraa Ehab on 02/06/2026.
//

import Foundation

protocol TeamDetailsViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func displayTeamDetails(team: Team)
    func displayFixtures(fixtures: [Event])   
    func showError(message: String)
}

protocol TeamDetailsPresenterProtocol {
    func viewDidLoad()
    func getTeamId() -> Int
}
