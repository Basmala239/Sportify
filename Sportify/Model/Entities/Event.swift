//
//  Match.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 24/05/2026.
//

import Foundation

// MARK: - Root Response
struct MatchesAPIResponse: Codable {
    let success: Int
    let result: [Event]
}

struct Event: Codable {
    let eventKey: String
    let eventDate: String
    let eventTime: String
    let eventHomeTeam: String
    let homeTeamKey: String
    let eventAwayTeam: String
    let awayTeamKey: String
    let eventHalftimeResult: String
    let eventFinalResult: String
    let eventFtResult: String
    let eventPenaltyResult: String
    let eventStatus: String
    let countryName: String
    let leagueName: String
    let leagueKey: String
    let leagueRound: String
    let leagueSeason: String
    let eventLive: String
    let eventStadium: String
    let eventReferee: String
    let homeTeamLogo: String
    let awayTeamLogo: String
    let eventCountryKey: String
    let leagueLogo: String
    let countryLogo: String
    let eventHomeFormation: String
    let eventAwayFormation: String
    let fkStageKey: String
    let stageName: String
    let leagueGroup: String
    let goalscorers: [Goalscorer]
    let substitutes: [Substitution]
    let cards: [Card]
    let lineups: Lineups
    let statistics: [Statistic]
    
    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case eventAwayTeam = "event_away_team"
        case awayTeamKey = "away_team_key"
        case eventHalftimeResult = "event_halftime_result"
        case eventFinalResult = "event_final_result"
        case eventFtResult = "event_ft_result"
        case eventPenaltyResult = "event_penalty_result"
        case eventStatus = "event_status"
        case countryName = "country_name"
        case leagueName = "league_name"
        case leagueKey = "league_key"
        case leagueRound = "league_round"
        case leagueSeason = "league_season"
        case eventLive = "event_live"
        case eventStadium = "event_stadium"
        case eventReferee = "event_referee"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
        case eventCountryKey = "event_country_key"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
        case eventHomeFormation = "event_home_formation"
        case eventAwayFormation = "event_away_formation"
        case fkStageKey = "fk_stage_key"
        case stageName = "stage_name"
        case leagueGroup = "league_group"
        case goalscorers
        case substitutes
        case cards
        case lineups
        case statistics
    }
}

// MARK: - Goalscorer
struct Goalscorer: Codable {
    let time: String?
    let homeScorer: Scorer?
    let awayScorer: Scorer?
    let score: String?
    
    enum CodingKeys: String, CodingKey {
        case time
        case homeScorer = "home_scorer"
        case awayScorer = "away_scorer"
        case score
    }
}

struct Scorer: Codable {
    let player: String?
    let goalType: String?
    
    enum CodingKeys: String, CodingKey {
        case player
        case goalType = "goal_type"
    }
}

// MARK: - Substitution
struct Substitution: Codable {
    let time: String
    let homeScorer: SubstitutionPlayer?
    let awayScorer: SubstitutionPlayer?
    let score: String
    
    enum CodingKeys: String, CodingKey {
        case time
        case homeScorer = "home_scorer"
        case awayScorer = "away_scorer"
        case score
    }
}

struct SubstitutionPlayer: Codable {
    let `in`: String
    let out: String
}

// MARK: - Card
struct Card: Codable {
    let time: String
    let homeFault: String
    let card: String
    let awayFault: String
    
    enum CodingKeys: String, CodingKey {
        case time
        case homeFault = "home_fault"
        case card
        case awayFault = "away_fault"
    }
}

// MARK: - Lineups
struct Lineups: Codable {
    let homeTeam: TeamLineup
    let awayTeam: TeamLineup
    
    enum CodingKeys: String, CodingKey {
        case homeTeam = "home_team"
        case awayTeam = "away_team"
    }
}

struct TeamLineup: Codable {
    let startingLineups: [PlayerLineup]
    let substitutes: [PlayerLineup]
    let coaches: [CoachInfo]
    let missingPlayers: [MissingPlayer]
    
    enum CodingKeys: String, CodingKey {
        case startingLineups = "starting_lineups"
        case substitutes
        case coaches
        case missingPlayers = "missing_players"
    }
}

struct PlayerLineup: Codable {
    let player: String
    let playerNumber: String
    let playerPosition: String
    let playerCountry: String?
    let playerKey: String
    
    enum CodingKeys: String, CodingKey {
        case player
        case playerNumber = "player_number"
        case playerPosition = "player_position"
        case playerCountry = "player_country"
        case playerKey = "player_key"
    }
}

struct CoachInfo: Codable {
    let coache: String
    let coacheCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case coache
        case coacheCountry = "coache_country"
    }
}

struct MissingPlayer: Codable {
    // Structure depends on API response
    // Add properties as needed
}

// MARK: - Statistic
struct Statistic: Codable {
    let type: String
    let home: String
    let away: String
}

// MARK: - Convenience Extensions
extension Event {
    var homeScore: Int {
        let components = eventFinalResult.components(separatedBy: " - ")
        return Int(components.first ?? "0") ?? 0
    }
    
    var awayScore: Int {
        let components = eventFinalResult.components(separatedBy: " - ")
        return Int(components.last ?? "0") ?? 0
    }
    
    var isLive: Bool {
        return eventLive == "1"
    }
    
    var isFinished: Bool {
        return eventStatus.lowercased() == "finished"
    }
    
    var dateAndTime: Date? {
        let dateString = "\(eventDate) \(eventTime)"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.date(from: dateString)
    }
}

extension TeamLineup {
    var startingXI: [PlayerLineup] {
        return startingLineups.filter { Int($0.playerPosition) ?? 0 <= 11 }
    }
    
    var benchPlayers: [PlayerLineup] {
        return substitutes
    }
    
    var headCoach: CoachInfo? {
        return coaches.first
    }
}

extension Statistic {
    var homeValue: Int {
        return Int(home) ?? 0
    }
    
    var awayValue: Int {
        return Int(away) ?? 0
    }
}
