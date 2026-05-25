//
//  SportsProtocols.swift
//  Sportify
//
//  Created by Esraa Ehab on 22/05/2026.
//

import Foundation

protocol SportsViewProtocol: AnyObject {
    func reloadData()
    func navigateToLeagues(with sportName: String)
}

protocol SportsPresenterProtocol {
    func viewDidLoad()
    func getSportsCount() -> Int
    func getSportItem(at index: Int) -> SportItem
    func didSelectSport(at index: Int)
}
