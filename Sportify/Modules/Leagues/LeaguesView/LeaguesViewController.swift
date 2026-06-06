//
//  LeaguesViewController.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 21/05/2026.
//

import UIKit

protocol LeaguesView: AnyObject {
    func startLoading()
    func stopLoading()
    func renderLeague(_ leagues: [League])
    func navigateToDetails(sportEndpoint: String, league: League)
    func noConnectionViewVisibility()
    func showError(_ message: String)
}

class LeaguesViewController: UIViewController, LeaguesView {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var leaguesTableView: UITableView!
    @IBOutlet weak var noLeaguesView: UIView!
    @IBOutlet weak var noConnection: UIView!
    
    var presenter: LeaguesPresenterProtocol = LeaguesPresenter()
    let indicator = UIActivityIndicatorView(style: .large)
    
    var leagues: [League] = []
    var sportEndpoint: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        
        noLeaguesView.isHidden = true
        noConnection.isHidden = true
        
        presenter.attachView(self)
        presenter.fetchData(for: sportEndpoint ?? APIEndpoints.football)
    }
    
    private func setupTableView() {
        leaguesTableView.delegate = self
        leaguesTableView.dataSource = self
        leaguesTableView.register(UINib(nibName: "CustemTableViewCell", bundle: nil), forCellReuseIdentifier: "leagues")
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.backgroundColor = .appSecondary
        searchBar.barTintColor = .appBackground
        searchBar.searchTextField.textColor = .appTitle
        searchBar.searchTextField.leftView?.tintColor = .appPrimary
    }
    
    func startLoading() {
        indicator.center = view.center
        indicator.color = .appLoadingColor
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    func stopLoading() {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }
    
    func renderLeague(_ leagues: [League]) {
        self.leagues = leagues
        updateViewVisibility()
    }
    
    func updateViewVisibility() {
        if leagues.isEmpty {
            leaguesTableView.isHidden = true
            noLeaguesView.isHidden = false
            noConnection.isHidden = true
        } else {
            leaguesTableView.isHidden = false
            noLeaguesView.isHidden = true
            noConnection.isHidden = true
        }
        leaguesTableView.reloadData()
    }
    
    func noConnectionViewVisibility() {
        leaguesTableView.isHidden = true
        noLeaguesView.isHidden = true
        noConnection.isHidden = false
        leaguesTableView.reloadData()
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error".localized, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK".localized, comment: ""), style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func navigateToDetails(sportEndpoint: String, league: League) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let detailsVC = storyboard.instantiateViewController(withIdentifier: "LeaguesDetailsViewController") as? LeaguesDetailsViewController {
            detailsVC.sportEndpoint = sportEndpoint
            detailsVC.league = league
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}

// MARK: - UISearchBarDelegate

extension LeaguesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.filterLeagues(with: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        presenter.filterLeagues(with: "")
        searchBar.resignFirstResponder()
    }
}
