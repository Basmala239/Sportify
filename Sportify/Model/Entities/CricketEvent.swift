//
//  CracktEvent.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 03/06/2026.
//

import Foundation

// MARK: - CricketApiResponse
struct CricketApiResponse: Decodable {
    let success: Int
    let result: [CricketEvent]?
}

// MARK: - CricketEvent
struct CricketEvent: Decodable {
    let eventKey: Int?
    let eventDateStart: String?
    let eventDateStop: String?
    let eventTime: String?
    let eventHomeTeam: String
    let homeTeamKey: Int?
    let eventAwayTeam: String
    let awayTeamKey: Int?
    let eventServiceHome: String?
    let eventServiceAway: String?
    let eventHomeFinalResult: String?
    let eventAwayFinalResult: String?
    let eventHomeRr: String?
    let eventAwayRr: String?
    let eventStatus: String
    let eventStatusInfo: String?
    let countryName: String?
    let leagueName: String?
    let leagueKey: Int?
    let leagueRound: String?
    let leagueSeason: String?
    let eventLive: String?
    let eventType: String?
    let eventToss: String?
    let eventManOfMatch: String?
    let eventStadium: String?
    let eventHomeTeamLogo: String?
    let eventAwayTeamLogo: String?
    
    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDateStart = "event_date_start"
        case eventDateStop = "event_date_stop"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case eventAwayTeam = "event_away_team"
        case awayTeamKey = "away_team_key"
        case eventServiceHome = "event_service_home"
        case eventServiceAway = "event_service_away"
        case eventHomeFinalResult = "event_home_final_result"
        case eventAwayFinalResult = "event_away_final_result"
        case eventHomeRr = "event_home_rr"
        case eventAwayRr = "event_away_rr"
        case eventStatus = "event_status"
        case eventStatusInfo = "event_status_info"
        case countryName = "country_name"
        case leagueName = "league_name"
        case leagueKey = "league_key"
        case leagueRound = "league_round"
        case leagueSeason = "league_season"
        case eventLive = "event_live"
        case eventType = "event_type"
        case eventToss = "event_toss"
        case eventManOfMatch = "event_man_of_match"
        case eventStadium = "event_stadium"
        case eventHomeTeamLogo = "event_home_team_logo"
        case eventAwayTeamLogo = "event_away_team_logo"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Robust multi-type check pattern for mixed Int/String API keys
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

        eventHomeTeam = try container.decodeIfPresent(String.self, forKey: .eventHomeTeam) ?? "Home Team"
        eventAwayTeam = try container.decodeIfPresent(String.self, forKey: .eventAwayTeam) ?? "Away Team"
        eventStatus = try container.decodeIfPresent(String.self, forKey: .eventStatus) ?? ""
        
        eventDateStart = try container.decodeIfPresent(String.self, forKey: .eventDateStart)
        eventDateStop = try container.decodeIfPresent(String.self, forKey: .eventDateStop)
        eventTime = try container.decodeIfPresent(String.self, forKey: .eventTime)
        eventServiceHome = try container.decodeIfPresent(String.self, forKey: .eventServiceHome)
        eventServiceAway = try container.decodeIfPresent(String.self, forKey: .eventServiceAway)
        eventHomeFinalResult = try container.decodeIfPresent(String.self, forKey: .eventHomeFinalResult)
        eventAwayFinalResult = try container.decodeIfPresent(String.self, forKey: .eventAwayFinalResult)
        eventHomeRr = try container.decodeIfPresent(String.self, forKey: .eventHomeRr)
        eventAwayRr = try container.decodeIfPresent(String.self, forKey: .eventAwayRr)
        eventStatusInfo = try container.decodeIfPresent(String.self, forKey: .eventStatusInfo)
        countryName = try container.decodeIfPresent(String.self, forKey: .countryName)
        leagueName = try container.decodeIfPresent(String.self, forKey: .leagueName)
        leagueRound = try container.decodeIfPresent(String.self, forKey: .leagueRound)
        leagueSeason = try container.decodeIfPresent(String.self, forKey: .leagueSeason)
        eventLive = try container.decodeIfPresent(String.self, forKey: .eventLive)
        eventType = try container.decodeIfPresent(String.self, forKey: .eventType)
        eventToss = try container.decodeIfPresent(String.self, forKey: .eventToss)
        eventManOfMatch = try container.decodeIfPresent(String.self, forKey: .eventManOfMatch)
        eventStadium = try container.decodeIfPresent(String.self, forKey: .eventStadium)
        eventHomeTeamLogo = try container.decodeIfPresent(String.self, forKey: .eventHomeTeamLogo)
        eventAwayTeamLogo = try container.decodeIfPresent(String.self, forKey: .eventAwayTeamLogo)
    }
}

