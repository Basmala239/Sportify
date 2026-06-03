//
//  TennisEvent.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 03/06/2026.
//

import Foundation

// MARK: - TennisApiResponse
struct TennisApiResponse: Codable {
    let success: Int
    let result: [TennisEvent]
}

// MARK: - TennisEvent
struct TennisEvent: Codable {
    let eventKey: String
    let eventDate: String
    let eventTime: String
    let eventFirstPlayer: String
    let firstPlayerKey: String
    let eventSecondPlayer: String
    let secondPlayerKey: String
    let eventFinalResult: String
    let eventGameResult: String
    let eventServe: String?
    let eventWinner: String?
    let eventStatus: String
    let countryName: String
    let leagueName: String
    let leagueKey: String
    let leagueRound: String
    let leagueSeason: String
    let eventLive: String
    let eventFirstPlayerLogo: String?
    let eventSecondPlayerLogo: String?
    let pointByPoint: [PointByPointSet]
    let scores: [SetScore]

    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventFirstPlayer = "event_first_player"
        case firstPlayerKey = "first_player_key"
        case eventSecondPlayer = "event_second_player"
        case secondPlayerKey = "second_player_key"
        case eventFinalResult = "event_final_result"
        case eventGameResult = "event_game_result"
        case eventServe = "event_serve"
        case eventWinner = "event_winner"
        case eventStatus = "event_status"
        case countryName = "country_name"
        case leagueName = "league_name"
        case leagueKey = "league_key"
        case leagueRound = "league_round"
        case leagueSeason = "league_season"
        case eventLive = "event_live"
        case eventFirstPlayerLogo = "event_first_player_logo"
        case eventSecondPlayerLogo = "event_second_player_logo"
        case pointByPoint = "pointbypoint"
        case scores
    }
}

// MARK: - PointByPointSet
struct PointByPointSet: Codable {
    let setNumber: String
    let numberGame: String
    let playerServed: String
    let serveWinner: String
    let serveLost: String?
    let score: String
    let points: [GamePoint]

    enum CodingKeys: String, CodingKey {
        case setNumber = "set_number"
        case numberGame = "number_game"
        case playerServed = "player_served"
        case serveWinner = "serve_winner"
        case serveLost = "serve_lost"
        case score
        case points
    }
}

// MARK: - GamePoint
struct GamePoint: Codable {
    let numberPoint: String
    let score: String
    let breakPoint: String?
    let setPoint: String?
    let matchPoint: String?

    enum CodingKeys: String, CodingKey {
        case numberPoint = "number_point"
        case score
        case breakPoint = "break_point"
        case setPoint = "set_point"
        case matchPoint = "match_point"
    }
}

// MARK: - SetScore
struct SetScore: Codable {
    let scoreFirst: String
    let scoreSecond: String
    let scoreSet: String

    enum CodingKeys: String, CodingKey {
        case scoreFirst = "score_first"
        case scoreSecond = "score_second"
        case scoreSet = "score_set"
    }
}
