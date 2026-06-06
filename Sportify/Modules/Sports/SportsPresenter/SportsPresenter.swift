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
        SportItem(name: "Football".localized, imageName: "football2"),
        SportItem(name: "Basketball".localized, imageName: "basketball2"),
        SportItem(name: "Tennis".localized, imageName: "tennies2"),
        SportItem(name: "Criecket".localized, imageName: "creckit2")
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
    
    
    func didSelectSport(at index: Int) {
        
        var navTo :String = APIEndpoints.football
        switch(index){
        case 0:
            navTo = APIEndpoints.football
        case 1:
            navTo = APIEndpoints.basketball
        case 2:
            navTo = APIEndpoints.tennis
        case 3:
            navTo = APIEndpoints.cricket
        default:
            navTo = APIEndpoints.football
        }
        view?.navigateToLeagues(with: navTo)
    }
}
