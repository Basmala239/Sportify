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
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    continuation.resume(returning: value)
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
/**
 the leagues in those
 https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=!_your_account_APIkey_!
 
 {
   "success": 1,
   "result": [
     {
          "league_key": "205",
          "league_name": "Coppa Italia",
          "country_key": "5",
          "country_name": "Italy",
          "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/205_coppa-italia.png",
          "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/5_italy.png"
      },
      {
          "league_key": "206",
          "league_name": "Serie B",
          "country_key": "5",
          "country_name": "Italy",
          "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/206_serie-b.png",
          "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/5_italy.png"
      },
      {
          "league_key": "207",
          "league_name": "Serie A",
          "country_key": "5",
          "country_name": "Italy",
          "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/207_serie-a.png",
          "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/5_italy.png"
      },
      .......
   ]
 }
 
 https://apiv2.allsportsapi.com/basketball/?met=Leagues&APIkey=!_your_account_APIkey_!

 {
   "success": 1,
   "result": [
     {
         "league_key": "766",
         "league_name": "NBA",
         "country_key": "197",
         "country_name": "USA"
     },
     {
          "league_key": "982",
          "league_name": "BIG3 (3x3)",
          "country_key": "197",
          "country_name": "USA"
      },
      {
          "league_key": "812",
          "league_name": "CBI",
          "country_key": "197",
          "country_name": "USA"
      },
      {
          "league_key": "813",
          "league_name": "CIT",
          "country_key": "197",
          "country_name": "USA"
      },
      {
          "league_key": "892",
          "league_name": "IBL",
          "country_key": "197",
          "country_name": "USA"
      },
      .......
   ]
 }
 
 https://apiv2.allsportsapi.com/cricket/?met=Leagues&APIkey=!_your_account_APIkey_!
 
 {
    "success": 1,
    "result": [
      {
           "league_key": "731",
           "league_name": "Pakistan Cup",
           "league_year": "2021/22"
       },
       {
             "league_key": "729",
             "league_name": "Pakistan Super League",
             "league_year": "2021/22"
       },
       {
           "league_key": "727",
           "league_name": "Plunket Shield",
           "league_year": "2021/22"
       },
       .......
    ]
 }
  
 
 https://apiv2.allsportsapi.com/tennis/?met=Leagues&APIkey=!_your_account_APIkey_!
 
 {
     "success": 1,
     "result": [
         {
             "league_key": "2833",
             "league_name": "Aachen",
             "country_key": "281",
             "country_name": "Challenger Men Singles"
         },
         {
             "league_key": "2655",
             "league_name": "Abu Dhabi",
             "country_key": "283",
             "country_name": "Exhibition Men"
         },
         {
             "league_key": "2801",
             "league_name": "Abu Dhabi",
             "country_key": "276",
             "country_name": "Exhibition Women"
         },
      .......
   ]
 }
             
 
 */
