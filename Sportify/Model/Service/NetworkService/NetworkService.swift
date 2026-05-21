//
//  NetworkService.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 21/05/2026.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocal {
    
}

class NetworkService : NetworkServiceProtocal {
    static let shared = NetworkService()
    private let baseURL = "https://apiv2.allsportsapi.com"
    private let apiKey = ""
    
    var session: Session
    
    init(session: Session = .default){
        self.session = session
    }
    
    
}
