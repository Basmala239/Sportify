import UIKit
import CoreData

class CoreDataManager {
    
     static let shared = CoreDataManager()
    
    private init() {}
    
    private var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func addFavorite(leagueKey: String, name: String?, imageString: String?, country: String?, endPoint: String?) {
         if isFavorite(leagueKey: leagueKey) {
            print("Item '\(leagueKey)' is already in favorites.")
            return
        }
        
        let favorite = Favorite(context: context)
        favorite.leagueKey = leagueKey
        favorite.name = name
        favorite.image = imageString
        favorite.countary = country
        favorite.endPoint = endPoint
         
        saveContext()
    }
    
    func deleteFavorite(leagueKey: String) {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %@", leagueKey)
        
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                context.delete(object)
            }
            saveContext()
            print("Successfully deleted '\(leagueKey)' from favorites.")
        } catch {
            print("Error deleting favorite item: \(error.localizedDescription)")
        }
    }
    
    func isFavorite(leagueKey: String) -> Bool {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %@", leagueKey)
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error checking favorite status: \(error.localizedDescription)")
            return false
        }
    }
    
    func fetchAllFavorites() -> [Favorite] {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch favorites: \(error.localizedDescription)")
            return []
        }
    }
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("Core Data Context Saved Successfully.")
            } catch {
                print("Failed to save context: \(error.localizedDescription)")
            }
        }
    }
}
extension CoreDataManager: FavoriteLocalProtocol {}
