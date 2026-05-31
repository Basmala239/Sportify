//
//  NetworkService.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 21/05/2026.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func isInternetConnected() -> Bool
    func getData<T: Decodable>(endpoint: String, met: String, parameters: [String: Any]?) async throws -> T
}

class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    private let baseURL = "https://apiv2.allsportsapi.com"
    private let apiKey = "7ebde3fcfa30451f23a08766df3aa8ae876c9f8f56d6646699f5ac00c50df742"
    
    var session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func getData<T: Decodable>(
        endpoint: String,
        met: String,
        parameters: [String: Any]? = nil
    ) async throws -> T {
        let url = baseURL + endpoint
        var params = parameters ?? [:]
        
        params["met"] = met
        params["APIkey"] = apiKey
        
        return try await withCheckedThrowingContinuation { continuation in
            session.request(
                url,
                method: .get,
                parameters: params,
                encoding: URLEncoding.default
            )
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedObject = try JSONDecoder().decode(T.self, from: data)
                        continuation.resume(returning: decodedObject)
                    } catch {
                        print("❌ DECODING ERROR DETAILS: \(error)")
                        if let rawJSON = String(data: data, encoding: .utf8) {
                            print(" RAW API RESPONSE WAS:\n\(rawJSON)")
                        }
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func isInternetConnected() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
