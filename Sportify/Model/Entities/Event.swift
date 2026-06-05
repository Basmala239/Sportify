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
        case eventFinalResult = "event_final_result"//
        case eventHomeFinalResult = "event_home_final_result"//
        case eventAwayFinalResult = "event_away_final_result"//
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


// MARK: - Sport Type Enum
enum SportType {
    case football, basketball, cricket, tennis
    
    var displayName: String {
        switch self {
        case .football: return "Football"
        case .basketball: return "Basketball"
        case .cricket: return "Cricket"
        case .tennis: return "Tennis"
        }
    }
}

// MARK: - Sport Event Protocol
protocol SportEvent {
    var eventId: String { get }
    var date: String { get }
    var time: String { get }
    var status: String { get }
    var leagueName: String { get }
}

// MARK: - Team Sport Event (Football, Basketball, Cricket)
struct TeamSportEvent: SportEvent {
    let eventId: String
    let date: String
    let time: String
    let status: String
    let leagueName: String
    let homeTeam: String
    let awayTeam: String
    let homeScore: String?
    let awayScore: String?
    let homeTeamLogo: String?
    let awayTeamLogo: String?
    let isUpcoming: Bool
    
    var displayResult: String {
        guard !isUpcoming else { return "VS" }
        if awayScore == "D"{
            return homeScore ?? "0 - 0"
        }
        return "\(homeScore ?? "0") - \(awayScore ?? "0")"
    }
}

// MARK: - Tennis Event
struct TennisEvent: SportEvent {
    let eventId: String
    let date: String
    let time: String
    let status: String
    let leagueName: String
    let firstPlayer: String
    let secondPlayer: String
    let winner: String?
    let firstPlayerLogo: String?
    let secondPlayerLogo: String?
    let scores: [String]
    
    
}

// MARK: - Event Factory
class EventFactory {
    static func createEvent(from rawEvent: Event, sportEndpoint: String, isUpcoming: Bool) -> SportEvent? {
        let sportType = getSportType(from: sportEndpoint)
        
        switch sportType {
        case .tennis:
            return TennisEvent(
                eventId: "\(rawEvent.eventKey ?? 0)",
                date: rawEvent.eventDate ?? "",
                time: rawEvent.eventTime ?? "",
                status: rawEvent.eventStatus ?? "",
                leagueName: rawEvent.leagueName ?? "",
                firstPlayer: rawEvent.eventFirstPlayer ?? "Player 1",
                secondPlayer: rawEvent.eventSecondPlayer ?? "Player 2",
                winner: rawEvent.eventWinner,
                firstPlayerLogo: rawEvent.eventFirstPlayerLogo,
                secondPlayerLogo: rawEvent.eventSecondPlayerLogo,
                scores: []
            )
        default:
            return TeamSportEvent(
                eventId: "\(rawEvent.eventKey ?? 0)",
                date: rawEvent.eventDate ?? rawEvent.eventDateStart ?? "",
                time: rawEvent.eventTime ?? "",
                status: rawEvent.eventStatus ?? "",
                leagueName: rawEvent.leagueName ?? "",
                homeTeam: rawEvent.HomeTeamName ?? rawEvent.eventFirstPlayer ?? "Home",
                awayTeam: rawEvent.AwayTeamName ?? rawEvent.eventSecondPlayer ?? "Away",
                homeScore: rawEvent.eventHomeFinalResult ?? rawEvent.eventFinalResult,
                awayScore: rawEvent.eventAwayFinalResult ??
                "D",
                homeTeamLogo: rawEvent.homeTeamLogo ?? rawEvent.event_home_team_logo,
                awayTeamLogo: rawEvent.awayTeamLogo ?? rawEvent.event_away_team_logo,
                isUpcoming: isUpcoming
            )
        }
    }
    
    private static func getSportType(from endpoint: String) -> SportType {
        switch endpoint {
        case APIEndpoints.tennis:
            return .tennis
        case APIEndpoints.basketball:
            return .basketball
        case APIEndpoints.cricket:
            return .cricket
        default:
            return .football
        }
    }
}
