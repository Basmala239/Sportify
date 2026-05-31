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
    func reloadData()
}
class LeaguesDetailsViewController: UITableViewController{
    
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    @IBOutlet weak var latestEventsCollectionView: UICollectionView!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
    @IBOutlet weak var noTeams: UIView!
    @IBOutlet weak var noUpcamingMatches: UIView!
    @IBOutlet weak var noLatestResult: UIView!
    
    var league: League?
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
        setupNavigationBarAppearance()
        let leaguesPresenter = LeaguesDetailspresenter()
        self.presenter = leaguesPresenter
        leaguesPresenter.attachView(self)
        leaguesPresenter.sportEndpointName = self.sportEndpoint ?? APIEndpoints.football
        
        Task {
            await leaguesPresenter.fetchLeagueDetails(league?.leagueKey)
        }
    }
    private func setupNavigationBarAppearance() {
        // Create a transparent appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.backgroundEffect = nil
        
        // Set title text attributes
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // Apply to both standard and scroll edge appearances
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        // Make navigation bar transparent
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear
        
        // Set tint color for buttons
        navigationController?.navigationBar.tintColor = .white
    }
    private func updateEmptyStateViews() {
            // Show/hide upcoming matches empty view
            noUpcamingMatches.isHidden = upcomingEvents.count > 0
            upcomingCollectionView.isHidden = upcomingEvents.count == 0
            
            // Show/hide latest results empty view
            noLatestResult.isHidden = latestEvents.count > 0
            latestEventsCollectionView.isHidden = latestEvents.count == 0
            
            // Show/hide teams empty view
            noTeams.isHidden = teams.count > 0
            teamsCollectionView.isHidden = teams.count == 0
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
            return CGSize(width: 350, height: 220)
        case latestEventsCollectionView:
            return CGSize(width: collectionView.frame.width - 30, height: 210)
        case teamsCollectionView:
            return CGSize(width: 170, height: 170)
        default:
            return CGSize(width: 100, height: 100)
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
extension LeaguesDetailsViewController: LeaguesDetailsView {
    func startLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.indicator.center = self.view.center
            self.view.addSubview(self.indicator)
            self.indicator.startAnimating()
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.indicator.stopAnimating()
            self.indicator.removeFromSuperview()
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.upcomingEvents = self.presenter?.upcomingMatches ?? []
            self.latestEvents = self.presenter?.latestMatches ?? []
            self.teams = self.presenter?.teams ?? []
            
            self.upcomingCollectionView.reloadData()
            self.latestEventsCollectionView.reloadData()
            self.teamsCollectionView.reloadData()
            
            // Update empty state views
            self.updateEmptyStateViews()
            
            self.tableView.reloadData()
        }
    }
}
