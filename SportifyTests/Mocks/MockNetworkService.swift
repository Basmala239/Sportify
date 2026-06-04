//
//  MockNetworkService.swift
//  SportifyTests
//
//  Created by Esraa Ehab on 04/06/2026.
//

import Foundation
@testable import Sportify

enum MockError: Error {
    case notImplemented
}


class MockNetworkService: NetworkServiceProtocol {
    
    var isConnected = true
    var stubbedData: Data?
    var isGetDataCalled = false
    
    func isInternetConnected() -> Bool {
        return isConnected
    }
    
    func getData<T>(endpoint: String, met: String, parameters: [String : Any]?) async throws -> T where T : Decodable {
        isGetDataCalled = true 
        guard let data = stubbedData else {
            throw MockError.notImplemented
        }
        
        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw error 
        }
    }
}
