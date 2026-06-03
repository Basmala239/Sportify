//
//  FavoriteViewController.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 20/05/2026.
//

import UIKit
protocol FavoriteView: AnyObject {
    func renderFavorite(_ favorites: [Favorite])
    func navigateToLeagueDetails(with league: Favorite)
    func showNoConnectionAlert()
}

class FavoriteViewController: UIViewController, FavoriteView {

    @IBOutlet weak var noFavView: UIView!
    @IBOutlet weak var imgView: UIView!
    @IBOutlet weak var favTableView: UITableView!

    var presenter: FavoritePresenter = FavoritePresenter()
    var favorites: [Favorite] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.layer.cornerRadius = imgView.frame.size.width / 2
        setupTableView()
        setupPresenter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchData()
    }
    
    private func setupTableView() {
        favTableView.delegate = self
        favTableView.dataSource = self
        favTableView.register(UINib(nibName: "CustemTableViewCell", bundle: nil), forCellReuseIdentifier: "leagues")
    }
    
    private func setupPresenter() {
        presenter.attachView(self)
    }
    
    func renderFavorite(_ favorites: [Favorite]) {
        self.favorites = favorites
        
        noFavView.isHidden = !favorites.isEmpty
        favTableView.isHidden = favorites.isEmpty
        
        favTableView.reloadData()
    }
    
    func navigateToLeagueDetails(with league: Favorite) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if(league.endPoint == APIEndpoints.tennis){
            guard let detailsVC = storyboard.instantiateViewController(withIdentifier: "TennisDetailViewController") as? TennisDetailViewController else { return }
            
            let name = league.name ?? "Leagues"
            let key = league.leagueKey ?? ""
            detailsVC.sportEndpoint = league.endPoint
            
            detailsVC.league = League(leagueKey: key, leagueName: name)
            
            self.navigationController?.pushViewController(detailsVC, animated: true)
            
        }else{
            guard let detailsVC = storyboard.instantiateViewController(withIdentifier: "LeaguesDetailsViewController") as? LeaguesDetailsViewController else { return }
            
            let name = league.name ?? "Leagues"
            let key = league.leagueKey ?? ""
            
            detailsVC.sportEndpoint = league.endPoint
            detailsVC.league = League(leagueKey: key, leagueName: name)
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
        
    }
    
    func showNoConnectionAlert() {
        let alert = UIAlertController(
            title: "No Internet Connection",
            message: "Please check your network settings and try again to view league details.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
