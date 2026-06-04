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
    var shouldReturnError = false
    var mockResponse: Decodable!
    
    func isInternetConnected() -> Bool {
        return isConnected
    }
    
    func getData<T: Decodable>(endpoint: String, met: String, parameters: [String: Any]?) async throws -> T {
        if shouldReturnError {
            throw NSError(domain: "NetworkError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Connection failed"])
        }
        if let response = mockResponse as? T {
            return response
        }
        throw NSError(domain: "DecodingError", code: -1, userInfo: nil)
    }
}
