//
//  LeaguesDetailsViewController.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 22/05/2026.
//

import UIKit
protocol LeaguesDetailsView: AnyObject {
    
}
class LeaguesDetailsViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    @IBOutlet weak var latestEventsCollectionView: UICollectionView!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
    // MARK: - Properties
    var leagueId: String?
    var leagueName: String?
    var leagueLogo: String?
    
    private var upcomingEvents: [Event] = []
    private var latestEvents: [Event] = []
    private var teams: [Team] = []
    
    private let favoritesKey = "favoriteLeagues"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupCollectionViews()
        loadData()
        setupFavoriteButton()
    }
    
   // MARK: - Setup Methods
    private func setupUI() {
        title = leagueName ?? "League Details"
        
    }
    
    private func setupCollectionViews() {
        // Upcoming Events - Horizontal
        upcomingCollectionView.delegate = self
        upcomingCollectionView.dataSource = self
        upcomingCollectionView.showsHorizontalScrollIndicator = false
        let upcomingLayout = UICollectionViewFlowLayout()
        upcomingLayout.scrollDirection = .horizontal
        upcomingLayout.minimumLineSpacing = 15
        upcomingLayout.minimumInteritemSpacing = 10
        upcomingLayout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        upcomingCollectionView.collectionViewLayout = upcomingLayout
        upcomingCollectionView.register(UINib(nibName: "UpcomingEventCell", bundle: nil), forCellWithReuseIdentifier: "UpcomingEventCell")
        
        // Latest Events - Vertical (Turn off scrolling to prevent friction with the Table View)
        latestEventsCollectionView.delegate = self
        latestEventsCollectionView.dataSource = self
        latestEventsCollectionView.isScrollEnabled = false
        let latestLayout = UICollectionViewFlowLayout()
        latestLayout.scrollDirection = .vertical
        latestLayout.minimumLineSpacing = 10
        latestLayout.minimumInteritemSpacing = 10
        latestLayout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        latestEventsCollectionView.collectionViewLayout = latestLayout
        latestEventsCollectionView.register(UINib(nibName: "LatestEventCell", bundle: nil), forCellWithReuseIdentifier: "LatestEventCell")
        
        // Teams - Horizontal
        teamsCollectionView.delegate = self
        teamsCollectionView.dataSource = self
        teamsCollectionView.showsHorizontalScrollIndicator = false
        let teamsLayout = UICollectionViewFlowLayout()
        teamsLayout.scrollDirection = .horizontal
        teamsLayout.minimumLineSpacing = 15
        teamsLayout.minimumInteritemSpacing = 10
        teamsLayout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        teamsCollectionView.collectionViewLayout = teamsLayout
        teamsCollectionView.register(UINib(nibName: "TeamCell", bundle: nil), forCellWithReuseIdentifier: "TeamCell")
    }
    
    private func setupFavoriteButton() {
        let favoriteButton = UIBarButtonItem(image: getFavoriteButtonImage(),
                                            style: .plain,
                                            target: self,
                                            action: #selector(favoriteButtonTapped))
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    private func getFavoriteButtonImage() -> UIImage? {
        guard let leagueId = leagueId else { return UIImage(systemName: "star") }
        
        let favorites = UserDefaults.standard.array(forKey: favoritesKey) as? [String] ?? []
        let isFavorite = favorites.contains(leagueId)
        let imageName = isFavorite ? "star.fill" : "star"
        return UIImage(systemName: imageName)
    }
    
    // MARK: - Data Loading
    private func loadData() {
        fetchUpcomingEvents()
        fetchLatestEvents()
        fetchTeams()
    }
    
    private func fetchUpcomingEvents() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.upcomingEvents = self?.createSampleUpcomingEvents() ?? []
            self?.upcomingCollectionView.reloadData()
        }
    }
    
    private func fetchLatestEvents() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.latestEvents = self?.createSampleLatestEvents() ?? []
            self?.latestEventsCollectionView.reloadData()
        }
    }
    
    private func fetchTeams() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.teams = self?.createSampleTeams() ?? []
            self?.teamsCollectionView.reloadData()
        }
    }
    
    // MARK: - Sample Data
    private func createSampleUpcomingEvents() -> [Event] {
        return [
            Event(eventName: "Manchester United vs Liverpool",
                  eventDate: "2024-06-15",
                  eventTime: "20:00",
                  homeTeamLogo: "manu_logo",
                  awayTeamLogo: "liv_logo"),
            Event(eventName: "Chelsea vs Arsenal",
                  eventDate: "2024-06-16",
                  eventTime: "18:30",
                  homeTeamLogo: "che_logo",
                  awayTeamLogo: "ars_logo"),
            Event(eventName: "Chelsea vs Arsenal",
                  eventDate: "2024-06-16",
                  eventTime: "18:30",
                  homeTeamLogo: "che_logo",
                  awayTeamLogo: "ars_logo"),
            Event(eventName: "Chelsea vs Arsenal",
                  eventDate: "2024-06-16",
                  eventTime: "18:30",
                  homeTeamLogo: "che_logo",
                  awayTeamLogo: "ars_logo"),
            Event(eventName: "Chelsea vs Arsenal",
                  eventDate: "2024-06-16",
                  eventTime: "18:30",
                  homeTeamLogo: "che_logo",
                  awayTeamLogo: "ars_logo"),
            Event(eventName: "Chelsea vs Arsenal",
                  eventDate: "2024-06-16",
                  eventTime: "18:30",
                  homeTeamLogo: "che_logo",
                  awayTeamLogo: "ars_logo")
        ]
    }
    
    private func createSampleLatestEvents() -> [Event] {
        return [
            Event(eventName: "Real Madrid vs Barcelona",
                  eventDate: "2024-05-20",
                  eventTime: "21:00",
                  homeTeamLogo: "rm_logo",
                  awayTeamLogo: "bar_logo",
                  homeScore: 2,
                  awayScore: 1),
            Event(eventName: "Bayern vs Dortmund",
                  eventDate: "2024-05-19",
                  eventTime: "19:30",
                  homeTeamLogo: "bay_logo",
                  awayTeamLogo: "dor_logo",
                  homeScore: 3,
                  awayScore: 2),
            Event(eventName: "Real Madrid vs Barcelona",
                  eventDate: "2024-05-20",
                  eventTime: "21:00",
                  homeTeamLogo: "rm_logo",
                  awayTeamLogo: "bar_logo",
                  homeScore: 2,
                  awayScore: 1),
            Event(eventName: "Bayern vs Dortmund",
                  eventDate: "2024-05-19",
                  eventTime: "19:30",
                  homeTeamLogo: "bay_logo",
                  awayTeamLogo: "dor_logo",
                  homeScore: 3,
                  awayScore: 2),
            Event(eventName: "Real Madrid vs Barcelona",
                  eventDate: "2024-05-20",
                  eventTime: "21:00",
                  homeTeamLogo: "rm_logo",
                  awayTeamLogo: "bar_logo",
                  homeScore: 2,
                  awayScore: 1),
            Event(eventName: "Bayern vs Dortmund",
                  eventDate: "2024-05-19",
                  eventTime: "19:30",
                  homeTeamLogo: "bay_logo",
                  awayTeamLogo: "dor_logo",
                  homeScore: 3,
                  awayScore: 2)
        ]
    }
    
    private func createSampleTeams() -> [Team] {
        return [
            Team(name: "Manchester United", logo: "manu_logo", id: "1"),
            Team(name: "Liverpool", logo: "liv_logo", id: "2"),
            Team(name: "Chelsea", logo: "che_logo", id: "3"),
            Team(name: "Arsenal", logo: "ars_logo", id: "4"),
            Team(name: "Manchester City", logo: "mci_logo", id: "5"),
            
            Team(name: "Liverpool", logo: "liv_logo", id: "2"),
            Team(name: "Chelsea", logo: "che_logo", id: "3"),
            Team(name: "Arsenal", logo: "ars_logo", id: "4"),
            Team(name: "Manchester City", logo: "mci_logo", id: "5"),
            Team(name: "Liverpool", logo: "liv_logo", id: "2"),
            Team(name: "Chelsea", logo: "che_logo", id: "3"),
            Team(name: "Arsenal", logo: "ars_logo", id: "4"),
            Team(name: "Manchester City", logo: "mci_logo", id: "5"),
            Team(name: "Liverpool", logo: "liv_logo", id: "2"),
            Team(name: "Chelsea", logo: "che_logo", id: "3"),
            Team(name: "Arsenal", logo: "ars_logo", id: "4"),
            Team(name: "Manchester City", logo: "mci_logo", id: "5")
        ]
    }
    
    // MARK: - Actions
    @objc private func favoriteButtonTapped() {
        guard let leagueId = leagueId else { return }
        
        var favorites = UserDefaults.standard.array(forKey: favoritesKey) as? [String] ?? []
        
        if favorites.contains(leagueId) {
            favorites.removeAll { $0 == leagueId }
            showAlert(message: "Removed from favorites")
        } else {
            favorites.append(leagueId)
            showAlert(message: "Added to favorites")
        }
        
        UserDefaults.standard.set(favorites, forKey: favoritesKey)
        navigationItem.rightBarButtonItem?.image = getFavoriteButtonImage()
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - Navigation
    private func navigateToTeamDetails(team: Team) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // Ensure this identifier matches your TeamDetailsViewController identity token in Storyboard
//        if let teamDetailsVC = storyboard.instantiateViewController(withIdentifier: "TeamDetailsViewController") as? TeamDetailsViewController {
//            teamDetailsVC.teamId = team.id
//            teamDetailsVC.teamName = team.name
//            teamDetailsVC.teamLogo = team.logo
//            navigationController?.pushViewController(teamDetailsVC, animated: true)
//        }
    }
}

// MARK: - UICollectionViewDataSource
extension LeaguesDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case upcomingCollectionView:
            return upcomingEvents.count
        case latestEventsCollectionView:
            return latestEvents.count
        case teamsCollectionView:
            return teams.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case upcomingCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingEventCell", for: indexPath) as! UpcomingEventCell
            let event = upcomingEvents[indexPath.item]
            cell.configure(with: event)
            return cell
            
        case latestEventsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestEventCell", for: indexPath) as! LatestEventCell
            let event = latestEvents[indexPath.item]
            cell.configure(with: event)
            return cell
            
        case teamsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! TeamCell
            let team = teams[indexPath.item]
            cell.configure(with: team)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension LeaguesDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == teamsCollectionView {
            let selectedTeam = teams[indexPath.item]
            navigateToTeamDetails(team: selectedTeam)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LeaguesDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case upcomingCollectionView:
            return CGSize(width: 280, height: 210)
        case latestEventsCollectionView:
            return CGSize(width: collectionView.frame.width - 30, height: 210)
        case teamsCollectionView:
            return CGSize(width: 170, height: 170)
        default:
            return CGSize(width: 100, height: 100)
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // A value of 0.0 is sometimes ignored by iOS, so 0.1 completely eliminates the space
        return 0.1
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Returning an empty view keeps UIKit from inserting default gray backgrounds
        return UIView()
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

// MARK: - Data Models
struct Event {
    let eventName: String
    let eventDate: String
    let eventTime: String
    let homeTeamLogo: String
    let awayTeamLogo: String
    var homeScore: Int?
    var awayScore: Int?
    
    init(eventName: String, eventDate: String, eventTime: String, homeTeamLogo: String, awayTeamLogo: String, homeScore: Int? = nil, awayScore: Int? = nil) {
        self.eventName = eventName
        self.eventDate = eventDate
        self.eventTime = eventTime
        self.homeTeamLogo = homeTeamLogo
        self.awayTeamLogo = awayTeamLogo
        self.homeScore = homeScore
        self.awayScore = awayScore
    }
}

struct Team {
    let name: String
    let logo: String
    let id: String
}
