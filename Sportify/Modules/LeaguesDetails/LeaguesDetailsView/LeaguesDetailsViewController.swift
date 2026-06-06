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
    func showError(_ message: String)
    func showEmptyState()
    func showNoInternetConnection()
}
class LeaguesDetailsViewController: UITableViewController{
    
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    @IBOutlet weak var latestEventsCollectionView: UICollectionView!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    @IBOutlet weak var noTeams: UIView!
    @IBOutlet weak var noUpcamingMatches: UIView!
    @IBOutlet weak var noLatestResult: UIView!
    @IBOutlet weak var thirdSectionTitle: UILabel!
    var league: League?
    var sportEndpoint: String?
    
    private var presenter: LeaguesDetailspresenterProtocol!
    private let indicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresenter()
        setupCollectionViews()
        fetchData()
        updateSectionTitle()
        setupNavigationBarElement()
    }
    
    private func updateSectionTitle() {
        thirdSectionTitle.text = presenter.sportType == .tennis ? "Players".localized : "Teams".localized
    }

    
    private func setupPresenter() {
       presenter = LeaguesDetailspresenter()
       presenter.attachView(self)
   }
    
    private func setupNavigationBarElement() {
        guard let leagueKey = league?.leagueKey else { return }
        
        let isFav = CoreDataManager.shared.isFavorite(leagueKey: leagueKey)
        let imageName = isFav ? "heart.fill" : "heart"
        
        let rightButton = UIBarButtonItem(
            image: UIImage(systemName: imageName),
            style: .plain,
            target: self,
            action: #selector(favoriteButtonTapped)
        )
        rightButton.tintColor = .systemRed
        self.navigationItem.rightBarButtonItem = rightButton
    }

    @objc private func favoriteButtonTapped() {
        guard let league = league else { return }
        let isNowFavorite = presenter.toggleFavorite(
            league: league,
            endpoint: sportEndpoint ?? APIEndpoints.football
        )
        
        let heartImage = isNowFavorite ? "heart.fill" : "heart"
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: heartImage)
    }
    
    func showEmptyState() {
        noUpcamingMatches.isHidden = presenter.upcomingMatches.count > 0
        upcomingCollectionView.isHidden = presenter.upcomingMatches.count == 0
        
        noLatestResult.isHidden = presenter.latestMatches.count > 0
        latestEventsCollectionView.isHidden = presenter.latestMatches.count == 0
        
        if(APIEndpoints.tennis !=  sportEndpoint){
            noTeams.isHidden = presenter.teams.count > 0
            teamsCollectionView.isHidden = presenter.teams.count == 0
        }else{
            noTeams.isHidden = presenter.players.count > 0
            teamsCollectionView.isHidden = presenter.players.count == 0
        }
    }
    
   // MARK: - Setup Methods
    private func setupCollectionViews() {
        if (sportEndpoint == APIEndpoints.tennis ){
            thirdSectionTitle.text = "Players".localized
        }else{
            thirdSectionTitle.text = "Teams".localized
        }
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
    
    private func fetchData() {
        presenter.fetchLeagueDetails(
            leagueId: league?.leagueKey,
            endpoint: sportEndpoint ?? APIEndpoints.football
        )
    }
    
    // MARK: - Navigation
    private func navigateToTeamDetails(team: Team) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let teamDetailsVC = storyboard.instantiateViewController(withIdentifier: "TeamDetailsViewController") as? TeamDetailsViewController {
            guard let teamId = team.teamKey else { return }
            
            let detailsPresenter = TeamDetailsPresenter(
                view: teamDetailsVC,
                teamId: teamId,
                sportEndpoint: self.sportEndpoint ?? APIEndpoints.football
            )
            
            teamDetailsVC.presenter = detailsPresenter
            
            navigationController?.pushViewController(teamDetailsVC, animated: true)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension LeaguesDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       switch collectionView {
       case upcomingCollectionView:
           return presenter.upcomingMatches.count
       case latestEventsCollectionView:
           return presenter.latestMatches.count
       case teamsCollectionView:
           return presenter.sportType == .tennis ? presenter.players.count : presenter.teams.count
       default:
           return 0
       }
   }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case upcomingCollectionView:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "UpcomingEventCell",
                for: indexPath
            ) as! UpcomingEventCell
            let event = presenter.upcomingMatches[indexPath.item]
            cell.configure(with: event)
            return cell
            
        case latestEventsCollectionView:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "LatestEventCell",
                for: indexPath
            ) as! LatestEventCell
            let event = presenter.latestMatches[indexPath.item]
            cell.configure(with: event)
            return cell
            
        case teamsCollectionView:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "TeamCell",
                for: indexPath
            ) as! TeamCell
            
            if presenter.sportType == .tennis {
                let player = presenter.players[indexPath.item]
                cell.configure(with: player)
            } else {
                let team = presenter.teams[indexPath.item]
                cell.configure(with: team)
            }
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension LeaguesDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == teamsCollectionView && presenter.sportType != .tennis {
            let team = presenter.teams[indexPath.item]
            navigateToTeamDetails(team: team)
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
    func showError(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(
                title: "Error".localized,
                message: message,
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(title: NSLocalizedString("OK".localized, comment: ""), style: .default) { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            
            alert.addAction(okAction)
            self?.present(alert, animated: true)
        }
    }
    
    func showNoInternetConnection() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(
                title: "No Internet Connection".localized,
                message: "Please check your network settings and try again to view league details.".localized,
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(title: NSLocalizedString("OK".localized, comment: ""), style: .default) { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            
            alert.addAction(okAction)
            self?.present(alert, animated: true)
        }
    }
    
    func startLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.indicator.center = self.view.center
            self.indicator.color = .appLoadingColor
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
            self?.updateSectionTitle()
            self?.upcomingCollectionView.reloadData()
            self?.latestEventsCollectionView.reloadData()
            self?.teamsCollectionView.reloadData()
            self?.showEmptyState()
        }
    }
}
