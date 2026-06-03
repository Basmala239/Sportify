//
//  PlayerProfile.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 04/06/2026.
//

import Foundation

// MARK: - PlayerProfileResponse
struct PlayerProfileResponse: Decodable {
    let success: Int
    let result: [PlayerProfile]?
}

// MARK: - PlayerProfile
struct PlayerProfile: Decodable {
    let playerKey: Int?
    let playerName: String
    let playerCountry: String?
    let playerBday: String?
    let playerLogo: String?
    
    // Detailed Profile Objects
    let stats: [PlayerSeasonStat]?
    let tournaments: [PlayerTournamentHistory]?

    enum CodingKeys: String, CodingKey {
        case playerKey = "player_key"
        case playerName = "player_name"
        case playerCountry = "player_country"
        case playerBday = "player_bday"
        case playerLogo = "player_logo"
        case stats, tournaments
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Robust multi-type check pattern if backend alters key formats
        if let intKey = try? container.decodeIfPresent(Int.self, forKey: .playerKey) {
            playerKey = intKey
        } else if let stringKey = try? container.decodeIfPresent(String.self, forKey: .playerKey), let intKey = Int(stringKey) {
            playerKey = intKey
        } else {
            playerKey = nil
        }
        
        playerName = try container.decodeIfPresent(String.self, forKey: .playerName) ?? "Unknown Player"
        playerCountry = try container.decodeIfPresent(String.self, forKey: .playerCountry)
        playerBday = try container.decodeIfPresent(String.self, forKey: .playerBday)
        playerLogo = try container.decodeIfPresent(String.self, forKey: .playerLogo)
        
        stats = try container.decodeIfPresent([PlayerSeasonStat].self, forKey: .stats)
        tournaments = try container.decodeIfPresent([PlayerTournamentHistory].self, forKey: .tournaments)
    }
}

// MARK: - PlayerSeasonStat
struct PlayerSeasonStat: Decodable {
    let season: String?
    let type: String? // "singles" / "doubles"
    let rank: String?
    let titles: String?
    let matchesWon: String?
    let matchesLost: String?
    let hardWon: String?
    let hardLost: String?
    let clayWon: String?
    let clayLost: String?
    let grassWon: String?
    let grassLost: String?

    enum CodingKeys: String, CodingKey {
        case season, type, rank, titles
        case matchesWon = "matches_won"
        case matchesLost = "matches_lost"
        case hardWon = "hard_won"
        case hardLost = "hard_lost"
        case clayWon = "clay_won"
        case clayLost = "clay_lost"
        case grassWon = "grass_won"
        case grassLost = "grass_lost"
    }
}

// MARK: - PlayerTournamentHistory
struct PlayerTournamentHistory: Decodable {
    let name: String? // e.g. "Rome", "Wimbledon"
    let season: String?
    let type: String?
    let surface: String? // e.g. "clay", "hard (indoor)"
    let prize: String?   // Mixed symbol strings like "€4,332,325" or "£13,490,000"
}
