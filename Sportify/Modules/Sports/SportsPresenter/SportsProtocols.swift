//
//  SportsProtocols.swift
//  Sportify
//
//  Created by Esraa Ehab on 22/05/2026.
//

import Foundation

protocol SportsViewProtocol: AnyObject {
    func reloadData()
}

protocol SportsPresenterProtocol {
    func viewDidLoad()
    func getSportsCount() -> Int
    func getSportItem(at index: Int) -> SportItem
}
