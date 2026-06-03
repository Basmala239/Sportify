//
//  Match.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 24/05/2026.
//
//
//  LeagueDetailsModel.swift
//  Sport Mob
//
//  Created by Al3dwy on 04/05/2026.
//

struct EventsResponse: Codable {
    let success: Int
    let result: [Event]?
}

struct Event: Codable {
    let eventKey: Int?
    let eventDate, eventTime, HomeTeamName: String?
    let eventDateStart: String?
    let homeTeamKey: Int?
    let AwayTeamName: String?
    let awayTeamKey: Int?
    let eventHalftimeResult, eventFinalResult, eventFtResult, eventPenaltyResult: String?
    let eventHomeFinalResult: String?
    let eventAwayFinalResult: String?
    let eventStatus, countryName, leagueName: String?
    let leagueKey: Int?
    let leagueRound, leagueSeason, eventLive, eventStadium: String?
    let eventReferee: String?
    let homeTeamLogo, awayTeamLogo: String?
    let eventCountryKey: Int?
    let leagueLogo, countryLogo: String?
    let eventHomeFormation, eventAwayFormation: String?
    let fkStageKey: Int?
    let stageName: String?
    let event_home_team_logo: String?
    let event_away_team_logo: String?
   
    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventDateStart = "event_date_start"
        case eventTime = "event_time"
        case HomeTeamName = "event_home_team"
        case homeTeamKey = "home_team_key"
        case AwayTeamName = "event_away_team"
        case awayTeamKey = "away_team_key"
        case eventHalftimeResult = "event_halftime_result"
        case eventFinalResult = "event_final_result"
        case eventHomeFinalResult = "event_home_final_result"
        case eventAwayFinalResult = "event_away_final_result"
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
        case event_home_team_logo = "event_home_team_logo"
        case event_away_team_logo = "event_away_team_logo"
    }
}
