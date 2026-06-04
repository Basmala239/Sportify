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
}


class LeaguesViewController: UIViewController, LeaguesView {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var leaguesTableView: UITableView!
    @IBOutlet weak var noLeaguesView: UIView!
    @IBOutlet weak var noConnection: UIView!
    
    var presenter: LeaguesPresenterProtocol = LeaguesPresenter()
    let indicator = UIActivityIndicatorView(style: .large)
    
    var leagues: [League] = []
    var allLeagues: [League] = []
    var sportEndpoint: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        
        noLeaguesView.isHidden = true
        
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
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.leftView?.tintColor = .white
    }
    
    func startLoading() {
        indicator.center = view.center
        indicator.color = .white
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    func stopLoading() {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }
    
    func renderLeague(_ leagues: [League]) {
        self.allLeagues = leagues
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
    
    func noConnectionViewVisibility(){
        leaguesTableView.isHidden = true
        noLeaguesView.isHidden = true
        noConnection.isHidden = false
        leaguesTableView.reloadData()
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
        
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            leagues = allLeagues
        } else {
            leagues = allLeagues.filter { league in
                league.leagueName.lowercased().contains(searchText.lowercased())
            }
        }
        updateViewVisibility()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        leagues = allLeagues
        updateViewVisibility()
        searchBar.resignFirstResponder()
    }
}
