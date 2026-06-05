//
//  PlayerDetailsResponse.swift
//  Sportify
//
//  Created by Esraa Ehab on 05/06/2026.
//

import Foundation

struct PlayerDetailsResponse: Decodable {
    let success: Int?
    let result: [PlayerDetails]?
}

struct PlayerDetails: Decodable {
    let playerKey: Int?
    let playerName: String?
    let playerType: String? 
    let teamName: String?
    let playerAge: String?
    let playerImage: String? 
    
    let playerGoals: String?
    let playerAssists: String?
    let playerMatchPlayed: String?
    let playerYellowCards: String?
    let playerRedCards: String?
    
    let playerPassesAccuracy: String?
    let playerShotsTotal: String?
    let playerDribbleSucc: String?
    let playerDuelsWon: String?
    
    enum CodingKeys: String, CodingKey {
        case playerKey = "player_key"
        case playerName = "player_name"
        case playerType = "player_type"
        case teamName = "team_name"
        case playerAge = "player_age"
        case playerImage = "player_image"
        
        case playerGoals = "player_goals"
        case playerAssists = "player_assists"
        case playerMatchPlayed = "player_match_played"
        case playerYellowCards = "player_yellow_cards"
        case playerRedCards = "player_red_cards"
        
        case playerPassesAccuracy = "player_passes_accuracy"
        case playerShotsTotal = "player_shots_total"
        case playerDribbleSucc = "player_dribble_succ"
        case playerDuelsWon = "player_duels_won"
    }
}
