//
//  FavoritePresenterTests.swift
//  SportifyTests
//
//  Created by Esraa Ehab on 03/06/2026.
//

import XCTest
import CoreData
@testable import Sportify

final class FavoritePresenterTests: XCTestCase {

    var presenter: FavoritePresenter!
    var mockView: MockFavoriteView!
    var mockNetwork: MockNetworkService!
    var mockLocalManager: MockFavoriteLocalManager!
    var mockContext: NSManagedObjectContext!

    override func setUp() {
        super.setUp()
        mockView = MockFavoriteView()
        mockNetwork = MockNetworkService()
        mockLocalManager = MockFavoriteLocalManager()
        mockContext = setUpInMemoryManagedObjectContext() 
        
        presenter = FavoritePresenter(networkService: mockNetwork, localManager: mockLocalManager)
        presenter.attachView(mockView)
    }

    override func tearDown() {
        presenter = nil
        mockView = nil
        mockNetwork = nil
        mockLocalManager = nil
        mockContext = nil
        super.tearDown()
    }

    // MARK: - Tests
    
    func testFetchData_CallsRenderFavorite_WithCorrectData() {
        let dummyFavorite = Favorite(context: mockContext)
        dummyFavorite.leagueKey = "141"
        dummyFavorite.name = "Premier League"
        mockLocalManager.stubbedFavorites = [dummyFavorite]
        
        presenter.fetchData()
        
        XCTAssertTrue(mockView.isRenderFavoriteCalled)
        XCTAssertEqual(mockView.renderedFavorites.first?.name, "Premier League")
    }
    
    

    // MARK: - Core Data Helper
    func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        try! persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }
}
