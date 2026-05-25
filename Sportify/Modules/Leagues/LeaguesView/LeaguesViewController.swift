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
    func navigateToDetails(sportEndpoint: String, leagueKey: String)}

class LeaguesViewController: UIViewController, LeaguesView {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var leaguesTableView: UITableView!
    
    var presenter: LeaguesPresenterProtocol = LeaguesPresenter()
    let indicator = UIActivityIndicatorView(style: .large)
    var leagues: [League] = []
    var sportEndpoint: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter.attachView(self)
        presenter.fetchData(for: sportEndpoint ?? APIEndpoints.football)
    }
    
    private func setupTableView() {
        leaguesTableView.delegate = self
        leaguesTableView.dataSource = self
        leaguesTableView.register(UINib(nibName: "CustemTableViewCell", bundle: nil), forCellReuseIdentifier: "leagues")
    }
    
    func startLoading() {
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    func stopLoading() {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }
    
    func renderLeague(_ leagues: [League]) {
        self.leagues = leagues
        leaguesTableView.reloadData()
    }
    
    func navigateToDetails(sportEndpoint: String, leagueKey: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsVC = storyboard.instantiateViewController(withIdentifier: "LeaguesDetailsViewController") as? LeaguesDetailsViewController {
            
            detailsVC.sportEndpoint = sportEndpoint
            detailsVC.leagueId = leagueKey
            
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}
