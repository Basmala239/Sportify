//
//  FavoriteViewController.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 20/05/2026.
//

import UIKit
protocol FavoriteView: AnyObject {
    func renderProducts(_ favorites: [Favorite])
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
    
    private func setupTableView() {
        favTableView.delegate = self
        favTableView.dataSource = self
        favTableView.register(UINib(nibName: "CustemTableViewCell", bundle: nil), forCellReuseIdentifier: "leagues")
    }
    
    private func setupPresenter() {
        presenter.attachView(self)
//        presenter.fetchData()
    }
    
    func renderProducts(_ favorites: [Favorite]) {
        self.favorites = favorites
        
        noFavView.isHidden = !favorites.isEmpty
        favTableView.isHidden = favorites.isEmpty
        
        favTableView.reloadData()
    }
}
