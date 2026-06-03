//
//  BasketBallEvent.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 03/06/2026.
//

import Foundation

// MARK: - BasketballApiResponse
struct BasketballApiResponse: Decodable {
    let success: Int
    let result: [BasketballEvent]?
}

// MARK: - BasketballEvent
struct BasketballEvent: Decodable {
    let eventKey: Int?
    let eventDate: String
    let eventTime: String
    let eventHomeTeam: String
    let homeTeamKey: Int?
    let eventAwayTeam: String
    let awayTeamKey: Int?
    let eventFinalResult: String?
    let eventQuarter: String?
    let eventStatus: String
    let countryName: String?
    let leagueName: String?
    let leagueKey: Int?
    let leagueRound: String?
    let leagueSeason: String?
    let eventLive: String?
    let eventHomeTeamLogo: String?
    let eventAwayTeamLogo: String?
    
    // Nested Data Fields
    let scores: BasketballQuarters?
    let statistics: [BasketballStat]?
    let lineups: BasketballLineups?
    let playerStatistics: BasketballPlayerStats?

    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case eventAwayTeam = "event_away_team"
        case awayTeamKey = "away_team_key"
        case eventFinalResult = "event_final_result"
        case eventQuarter = "event_quarter"
        case eventStatus = "event_status"
        case countryName = "country_name"
        case leagueName = "league_name"
        case leagueKey = "league_key"
        case leagueRound = "league_round"
        case leagueSeason = "league_season"
        case eventLive = "event_live"
        case eventHomeTeamLogo = "event_home_team_logo"
        case eventAwayTeamLogo = "event_away_team_logo"
        case scores, statistics, lineups
        case playerStatistics = "player_statistics"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Handle variations where keys could be sent as Int or String from API
        if let intKey = try? container.decodeIfPresent(Int.self, forKey: .eventKey) {
            eventKey = intKey
        } else if let stringKey = try? container.decodeIfPresent(String.self, forKey: .eventKey), let intKey = Int(stringKey) {
            eventKey = intKey
        } else {
            eventKey = nil
        }
        
        if let intHomeKey = try? container.decodeIfPresent(Int.self, forKey: .homeTeamKey) {
            homeTeamKey = intHomeKey
        } else if let stringHomeKey = try? container.decodeIfPresent(String.self, forKey: .homeTeamKey), let intKey = Int(stringHomeKey) {
            homeTeamKey = intKey
        } else {
            homeTeamKey = nil
        }
        
        if let intAwayKey = try? container.decodeIfPresent(Int.self, forKey: .awayTeamKey) {
            awayTeamKey = intAwayKey
        } else if let stringAwayKey = try? container.decodeIfPresent(String.self, forKey: .awayTeamKey), let intKey = Int(stringAwayKey) {
            awayTeamKey = intKey
        } else {
            awayTeamKey = nil
        }
        
        if let intLeagueKey = try? container.decodeIfPresent(Int.self, forKey: .leagueKey) {
            leagueKey = intLeagueKey
        } else if let stringLeagueKey = try? container.decodeIfPresent(String.self, forKey: .leagueKey), let intKey = Int(stringLeagueKey) {
            leagueKey = intKey
        } else {
            leagueKey = nil
        }

        eventDate = try container.decodeIfPresent(String.self, forKey: .eventDate) ?? ""
        eventTime = try container.decodeIfPresent(String.self, forKey: .eventTime) ?? ""
        eventHomeTeam = try container.decodeIfPresent(String.self, forKey: .eventHomeTeam) ?? "Home Team"
        eventAwayTeam = try container.decodeIfPresent(String.self, forKey: .eventAwayTeam) ?? "Away Team"
        eventFinalResult = try container.decodeIfPresent(String.self, forKey: .eventFinalResult)
        eventQuarter = try container.decodeIfPresent(String.self, forKey: .eventQuarter)
        eventStatus = try container.decodeIfPresent(String.self, forKey: .eventStatus) ?? ""
        countryName = try container.decodeIfPresent(String.self, forKey: .countryName)
        leagueName = try container.decodeIfPresent(String.self, forKey: .leagueName)
        leagueRound = try container.decodeIfPresent(String.self, forKey: .leagueRound)
        leagueSeason = try container.decodeIfPresent(String.self, forKey: .leagueSeason)
        eventLive = try container.decodeIfPresent(String.self, forKey: .eventLive)
        eventHomeTeamLogo = try container.decodeIfPresent(String.self, forKey: .eventHomeTeamLogo)
        eventAwayTeamLogo = try container.decodeIfPresent(String.self, forKey: .eventAwayTeamLogo)
        
        scores = try container.decodeIfPresent(BasketballQuarters.self, forKey: .scores)
        statistics = try container.decodeIfPresent([BasketballStat].self, forKey: .statistics)
        lineups = try container.decodeIfPresent(BasketballLineups.self, forKey: .lineups)
        playerStatistics = try container.decodeIfPresent(BasketballPlayerStats.self, forKey: .playerStatistics)
    }
}

// MARK: - BasketballQuarters
struct BasketballQuarters: Decodable {
    let firstQuarter: [QuarterScore]?
    let secondQuarter: [QuarterScore]?
    let thirdQuarter: [QuarterScore]?
    let fourthQuarter: [QuarterScore]?

    enum CodingKeys: String, CodingKey {
        case firstQuarter = "1stQuarter"
        case secondQuarter = "2ndQuarter"
        case thirdQuarter = "3rdQuarter"
        case fourthQuarter = "4thQuarter"
    }
}

struct QuarterScore: Decodable {
    let scoreHome: String?
    let scoreAway: String?

    enum CodingKeys: String, CodingKey {
        case scoreHome = "score_home"
        case scoreAway = "score_away"
    }
}

// MARK: - BasketballStat
struct BasketballStat: Decodable {
    let type: String?
    let home: String?
    let away: String?
}

// MARK: - BasketballLineups
struct BasketballLineups: Decodable {
    let homeTeam: TeamLineup?
    let awayTeam: TeamLineup?

    enum CodingKeys: String, CodingKey {
        case homeTeam = "home_team"
        case awayTeam = "away_team"
    }
}

struct TeamLineup: Decodable {
    let startingLineups: [BasketballPlayer]?
    let substitutes: [BasketballPlayer]?

    enum CodingKeys: String, CodingKey {
        case startingLineups = "starting_lineups"
        case substitutes
    }
}

struct BasketballPlayer: Decodable {
    let player: String?
    let playerId: String?

    enum CodingKeys: String, CodingKey {
        case player
        case playerId = "player_id"
    }
}

// MARK: - BasketballPlayerStats
struct BasketballPlayerStats: Decodable {
    let homeTeam: [BasketballPlayerPerformance]?
    let awayTeam: [BasketballPlayerPerformance]?

    enum CodingKeys: String, CodingKey {
        case homeTeam = "home_team"
        case awayTeam = "away_team"
    }
}

struct BasketballPlayerPerformance: Decodable {
    let player: String?
    let playerId: String?
    let playerAssists: String?
    let playerBlocks: String?
    let playerDefenseRebounds: String?
    let playerFieldGoalsAttempts: String?
    let playerFieldGoalsMade: String?
    let playerFreethrowsGoalsAttempts: String?
    let playerFreethrowsGoalsMade: String?
    let playerMinutes: String?
    let playerOffenceRebounds: String?
    let playerOncourt: String?
    let playerPersonalFouls: String?
    let playerPlusMinus: String?
    let playerPosition: String?
    let playerPoints: String?
    let playerSteals: String?
    let playerThreepointGoalsAttempts: String?
    let playerThreepointGoalsMade: String?
    let playerTotalRebounds: String?
    let playerTurnovers: String?

    enum CodingKeys: String, CodingKey {
        case player
        case playerId = "player_id"
        case playerAssists = "player_assists"
        case playerBlocks = "player_blocks"
        case playerDefenseRebounds = "player_defense_rebounds"
        case playerFieldGoalsAttempts = "player_field_goals_attempts"
        case playerFieldGoalsMade = "player_field_goals_made"
        case playerFreethrowsGoalsAttempts = "player_freethrows_goals_attempts"
        case playerFreethrowsGoalsMade = "player_freethrows_goals_made"
        case playerMinutes = "player_minutes"
        case playerOffenceRebounds = "player_offence_rebounds"
        case playerOncourt = "player_oncourt"
        case playerPersonalFouls = "player_personal_fouls"
        case playerPlusMinus = "player_plus_minus"
        case playerPosition = "player_position"
        case playerPoints = "player_points"
        case playerSteals = "player_steals"
        case playerThreepointGoalsAttempts = "player_threepoint_goals_attempts"
        case playerThreepointGoalsMade = "player_threepoint_goals_made"
        case playerTotalRebounds = "player_total_rebounds"
        case playerTurnovers = "player_turnovers"
    }
}
