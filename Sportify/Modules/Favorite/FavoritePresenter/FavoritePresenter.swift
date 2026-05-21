//
//  FavoritePresenter.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 20/05/2026.
//
import Foundation

class FavoritePresenter {
    
    private weak var view: FavoriteView?
    private let storageService: LocalStorageService
    private var result: [Favorite] = []
    
    init(storageService: LocalStorageService = CoreDataManager.shared) {
        self.storageService = storageService
    }
    
    func attachView(_ view: FavoriteView) {
        self.view = view
    }
    
    func fetchData() {
        storageService.fetchFavorites { [weak self] response in
            guard let self = self else { return }
            
            switch response {
            case .success(let localFavorites):
                self.result = localFavorites
                DispatchQueue.main.async {
                    self.view?.renderProducts(localFavorites)
                }
            case .failure(let error):
                print("Error loading local data: \(error.localizedDescription)")
            }
        }
    }
}
