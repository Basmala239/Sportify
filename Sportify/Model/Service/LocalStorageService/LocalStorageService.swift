//
//  LocalStorageService.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 21/05/2026.
//

import Foundation
import CoreData

protocol LocalStorageService {
    func fetchFavorites(completion: @escaping (Result<[Favorite], Error>) -> Void)
}

class CoreDataManager: LocalStorageService {
    
    static let shared = CoreDataManager()
    private init() {}
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Sportify")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Fetch Operation
    func fetchFavorites(completion: @escaping (Result<[Favorite], Error>) -> Void) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteEntity")
        
//        do {
//            let managedObjects = try context.fetch(fetchRequest)
//
//            let favorites = managedObjects.map { object -> Favorite in
//                let name = object.value(forKey: "name") as? String ?? ""
//                let image = object.value(forKey: "image") as? String ?? ""
//                return
//            }
//            completion(.success(favorites))
//        } catch let error {
//            completion(.failure(error))
//        }
    }
}
