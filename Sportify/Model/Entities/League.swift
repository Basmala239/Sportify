//
//  Leagues.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 22/05/2026.
//

import Foundation

struct LeagueResponse: Decodable {
    let success: Int
    let result: [League]?
}

struct League: Decodable {
    let leagueKey: String
    let leagueName: String
    let countryKey: String?
    let countryName: String?
    let leagueLogo: String?
    let countryLogo: String?
    let leagueYear: String?
    
    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryKey = "country_key"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
        case leagueYear = "league_year"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let stringKey = try? container.decode(String.self, forKey: .leagueKey) {
            self.leagueKey = stringKey
        } else if let intKey = try? container.decode(Int.self, forKey: .leagueKey) {
            self.leagueKey = String(intKey)
        } else {
            throw DecodingError.dataCorruptedError(forKey: .leagueKey, in: container, debugDescription: "league_key is missing or not a valid type")
        }
        
        self.leagueName = try container.decodeIfPresent(String.self, forKey: .leagueName) ?? "Unknown League"
        self.countryName = try container.decodeIfPresent(String.self, forKey: .countryName)
        self.leagueLogo = try container.decodeIfPresent(String.self, forKey: .leagueLogo)
        self.countryLogo = try container.decodeIfPresent(String.self, forKey: .countryLogo)
        self.leagueYear = try container.decodeIfPresent(String.self, forKey: .leagueYear)
        
        
        if let stringCountryKey = try? container.decode(String.self, forKey: .countryKey) {
            self.countryKey = stringCountryKey
        } else if let intCountryKey = try? container.decode(Int.self, forKey: .countryKey) {
            self.countryKey = String(intCountryKey)
        } else {
            self.countryKey = nil
        }
    }
}
