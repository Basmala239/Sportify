//
//  SportsPresenter.swift
//  Sportify
//
//  Created by Esraa Ehab on 22/05/2026.
//

import Foundation

class SportsPresenter: SportsPresenterProtocol {
    
    private weak var view: SportsViewProtocol?
    
    private let sportsList: [SportItem] = [
        SportItem(name: "Football", imageName: "football2"),
        SportItem(name: "Basketball", imageName: "basketball2"),
        SportItem(name: "Tennis", imageName: "tennies2"),
        SportItem(name: "Criecket", imageName: "creckit2")
    ]
    
    init(view: SportsViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.reloadData()
    }
    
    func getSportsCount() -> Int {
        return sportsList.count
    }
    
    func getSportItem(at index: Int) -> SportItem {
        return sportsList[index]
    }
}
