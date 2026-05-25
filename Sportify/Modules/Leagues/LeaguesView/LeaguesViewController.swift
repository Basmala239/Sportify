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
}

class LeaguesViewController: UIViewController, LeaguesView {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var leaguesTableView: UITableView!
    
    var presenter: LeaguesPresenterProtocol = LeaguesPresenter()
    let indicator = UIActivityIndicatorView(style: .large)
    var leagues: [League] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter.attachView(self)
        presenter.fetchData(for: APIEndpoints.football)
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
}
