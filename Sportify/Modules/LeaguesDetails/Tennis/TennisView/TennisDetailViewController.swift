//
//  TennisDetailViewController.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 03/06/2026.
//

import UIKit

protocol TennisDetailsView: AnyObject {
    func startLoading()
    func stopLoading()
    func reloadData()
}
class TennisDetailViewController: UITableViewController{
    
        
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    @IBOutlet weak var latestEventsCollectionView: UICollectionView!

    @IBOutlet weak var noUpcamingMatches: UIView!
    @IBOutlet weak var noLatestResult: UIView!
    
    var league: League?
    var sportEndpoint: String?
    private var upcomingEvents: [TennisEvent] = []
    private var latestEvents: [TennisEvent] = []
    
    private var presenter: TennispresenterProtocol!
    private let indicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
        setupNavigationBarElement()
        
        let tennisPresenter = TennisPresenter()
        tennisPresenter.sportEndpointName = self.sportEndpoint ?? APIEndpoints.football
        tennisPresenter.attachView(self)
        
        self.presenter = tennisPresenter
        
        Task {
            await presenter.fetchLeagueDetails(league?.leagueKey)
        }
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
        guard let leagueKey = league?.leagueKey else { return }
        
        if CoreDataManager.shared.isFavorite(leagueKey: leagueKey) {
            CoreDataManager.shared.deleteFavorite(leagueKey: leagueKey)
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
            print("Successfully removed league \(leagueKey) from favorites.")
        } else {
            CoreDataManager.shared.addFavorite(
                leagueKey: leagueKey,
                name: league?.leagueName,
                imageString: league?.leagueLogo ?? "",
                country: league?.countryName ?? "",
                endPoint: sportEndpoint ?? ""
            )
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
            print("Successfully added league \(leagueKey) to favorites.")
        }
    }
    
    private func updateEmptyStateViews() {
        noUpcamingMatches.isHidden = upcomingEvents.count > 0
        upcomingCollectionView.isHidden = upcomingEvents.count == 0
        
        noLatestResult.isHidden = latestEvents.count > 0
        latestEventsCollectionView.isHidden = latestEvents.count == 0
    }
    
   // MARK: - Setup Methods

    
    private func setupCollectionViews() {
        upcomingCollectionView.delegate = self
        upcomingCollectionView.dataSource = self
        upcomingCollectionView.register(UINib(nibName: "UpcomingEventCell", bundle: nil), forCellWithReuseIdentifier: "UpcomingEventCell")
        
        
        latestEventsCollectionView.delegate = self
        latestEventsCollectionView.dataSource = self
        latestEventsCollectionView.register(UINib(nibName: "LatestEventCell", bundle: nil), forCellWithReuseIdentifier: "LatestEventCell")
    }
}

// MARK: - UICollectionViewDataSource
extension TennisDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case upcomingCollectionView:
            return upcomingEvents.count
        case latestEventsCollectionView:
            return latestEvents.count
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
            
        default:
            return UICollectionViewCell()
        }
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension TennisDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case upcomingCollectionView:
            return CGSize(width: 350, height: 220)
        case latestEventsCollectionView:
            return CGSize(width: collectionView.frame.width - 30, height: 210)
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
extension TennisDetailViewController: TennisDetailsView {
    
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
            
            self.upcomingEvents = self.presenter.upcomingMatches
            self.latestEvents = self.presenter.latestMatches
            
            self.upcomingCollectionView.reloadData()
            self.latestEventsCollectionView.reloadData()
            
            self.updateEmptyStateViews()
            self.tableView.reloadData()
        }
    }
}
