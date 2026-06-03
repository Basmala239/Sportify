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

struct EventsResponse: Decodable {
    let success: Int
    let result: [Event]?
}

struct Event: Decodable {
    let eventKey: Int?
    let eventDate: String?
    let eventTime: String?
    let HomeTeamName: String?
    let eventDateStart: String?
    let homeTeamKey: Int?
    let AwayTeamName: String?
    let awayTeamKey: Int?
    let eventHalftimeResult: String?
    let eventFinalResult: String?
    let eventFtResult: String?
    let eventPenaltyResult: String?
    let eventHomeFinalResult: String?
    let eventAwayFinalResult: String?
    let eventStatus: String?
    let countryName: String?
    let leagueName: String?
    let leagueKey: Int?
    let leagueRound: String?
    let leagueSeason: String?
    let eventLive: String?
    let eventStadium: String?
    let eventReferee: String?
    let homeTeamLogo: String?
    let awayTeamLogo: String?
    let eventCountryKey: Int?
    let leagueLogo: String?
    let countryLogo: String?
    let eventHomeFormation: String?
    let eventAwayFormation: String?
    let fkStageKey: Int?
    let stageName: String?
    let event_home_team_logo: String?
    let event_away_team_logo: String?
    let firstPlayerKey: Int?
    let eventSecondPlayer: String?
    let secondPlayerKey: Int?
    let eventGameResult: String?
    let eventServe: String?
    let eventWinner: String?
    let eventFirstPlayerLogo: String?
    let eventSecondPlayerLogo: String?
    let eventFirstPlayer: String?
    
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
        case eventFirstPlayer = "event_first_player"
        case firstPlayerKey = "first_player_key"
        case eventSecondPlayer = "event_second_player"
        case secondPlayerKey = "second_player_key"
        case eventGameResult = "event_game_result"
        case eventServe = "event_serve"
        case eventWinner = "event_winner"
        case eventFirstPlayerLogo = "event_first_player_logo"
        case eventSecondPlayerLogo = "event_second_player_logo"
    }
}
