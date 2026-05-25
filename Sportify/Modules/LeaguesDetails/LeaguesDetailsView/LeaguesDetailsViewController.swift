//
//  LeaguesDetailsViewController.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 22/05/2026.
//

import UIKit
protocol LeaguesDetailsView: AnyObject {
    func startLoading()
    func stopLoading()
    func renderUpcomingEvents(_ upcomingEvents: [Event])
    func renderLatestEvents(_ latestEvents: [Event])
    func renderTeams(_ teams: [Team])
}
class LeaguesDetailsViewController: UITableViewController{
    
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    @IBOutlet weak var latestEventsCollectionView: UICollectionView!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
    var leagueId: String?
    var sportEndpoint: String?
    private var upcomingEvents: [Event] = []
    private var latestEvents: [Event] = []
    private var teams: [Team] = []
    private var presenter: LeaguesDetailspresenterProtocol!
    private let indicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupCollectionViews()
        
        let leaguesPresenter = LeaguesDetailspresenter()
        self.presenter = leaguesPresenter
        leaguesPresenter.attachView(self)
        
//        // Pass view data context down to the presenter state
//        leaguesPresenter.sportEndpointName = "/football/" // Dynamically set this based on what sport was selected
//        leaguesPresenter.leagueId = self.leagueId
        
        Task {
                await leaguesPresenter.fetchLeagueDetails(leagueId)
            }
    }
    
   // MARK: - Setup Methods

    
    private func setupCollectionViews() {
        upcomingCollectionView.delegate = self
        upcomingCollectionView.dataSource = self
        upcomingCollectionView.register(UINib(nibName: "UpcomingEventCell", bundle: nil), forCellWithReuseIdentifier: "UpcomingEventCell")
        
        
        latestEventsCollectionView.delegate = self
        latestEventsCollectionView.dataSource = self
        latestEventsCollectionView.register(UINib(nibName: "LatestEventCell", bundle: nil), forCellWithReuseIdentifier: "LatestEventCell")
        
        teamsCollectionView.delegate = self
        teamsCollectionView.dataSource = self
        teamsCollectionView.showsHorizontalScrollIndicator = false
        teamsCollectionView.register(UINib(nibName: "TeamCell", bundle: nil), forCellWithReuseIdentifier: "TeamCell")
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
extension LeaguesDetailsViewController: LeaguesDetailsView {
    func startLoading() {
        DispatchQueue.main.async { [weak self] in // 👈 Wrap in main queue
            guard let self = self else { return }
            self.indicator.center = self.view.center
            self.view.addSubview(self.indicator)
            self.indicator.startAnimating()
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async { [weak self] in // 👈 Wrap in main queue
            guard let self = self else { return }
            self.indicator.stopAnimating()
            self.indicator.removeFromSuperview()
        }
    }
    
    func renderUpcomingEvents(_ upcomingEvents: [Event]) {
        DispatchQueue.main.async { [weak self] in
            self?.upcomingEvents = upcomingEvents
            // self?.upcomingCollectionView.reloadData() // Don't forget to reload if needed!
        }
    }
    
    func renderLatestEvents(_ latestEvents: [Event]) {
        DispatchQueue.main.async { [weak self] in
            self?.latestEvents = latestEvents
            // self?.latestEventsCollectionView.reloadData()
        }
    }
    
    func renderTeams(_ teams: [Team]) {
        DispatchQueue.main.async { [weak self] in 
            self?.teams = teams
            self?.teamsCollectionView.reloadData()
        }
    }
}
