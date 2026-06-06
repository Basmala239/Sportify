//
//  TeamDetailsViewController.swift
//  Sportify
//
//  Created by Esraa Ehab on 30/05/2026.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    @IBOutlet weak var teamTableView: UITableView!
    
        var presenter: TeamDetailsPresenterProtocol!
        var teamData: Team?
        var fixtures: [Event] = []
    
        
        private let indicator = UIActivityIndicatorView(style: .large)
    
    var tableSections: [String] = []
    var playersBySection: [[Player]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewHeader()
        setupTableView()
        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
    }
    
    private func setupTableViewHeader() {
        let headerView = TeamHeaderView(frame: CGRect(x: 0, y: 0, width: teamTableView.frame.width, height: 170))
            teamTableView.tableHeaderView = headerView
    }
    
    func setupTableView(){
        let nib =  UINib(nibName: "PlayersRowTableViewCell", bundle: nil)
        teamTableView.register(nib, forCellReuseIdentifier: "PlayersRowTableViewCell")
        
        let fixtureNib = UINib(nibName: "FixtureTableViewCell", bundle: nil)
        teamTableView.register(fixtureNib, forCellReuseIdentifier: "FixtureTableViewCell")
        
        teamTableView.dataSource = self
        teamTableView.delegate = self
        
        //teamTableView.rowHeight = 240
        teamTableView.separatorStyle = .none
        
        if #available(iOS 15.0, *) {
           teamTableView.sectionHeaderTopPadding = 40
            
            
        }
    }
}


extension TeamDetailsViewController : UITableViewDataSource , UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableSections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTitle = tableSections[section]
            if sectionTitle == "Fixtures" {
                return fixtures.count
            }
            return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let sectionTitle = tableSections[indexPath.section]
            if sectionTitle == "Fixtures" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FixtureTableViewCell", for: indexPath) as! FixtureTableViewCell
                let match = fixtures[indexPath.row]
                cell.configure(with: match)
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersRowTableViewCell", for: indexPath) as! PlayersRowTableViewCell
                cell.selectionStyle = .none
                let playersForThisSection = playersBySection[indexPath.section]
                cell.configure(with: playersForThisSection)
                cell.onPlayerTapped = { [weak self] selectedPlayer in
                    guard let self = self else { return }
                    
//                    guard self.currentSport == "football" else {
//                        self.showError(message: "player details available for football only ⚽️")
//                        return
//                    }
                   
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let playerDetailsVC = storyboard.instantiateViewController(withIdentifier: "PlayerDetailsViewController") as? PlayerDetailsViewController {
                        
                        playerDetailsVC.player = selectedPlayer
                        
                        playerDetailsVC.teamName = self.teamData?.teamName
                        
                        self.navigationController?.pushViewController(playerDetailsVC, animated: true)
                    }
                }
                
                return cell
            }
        }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableSections[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView{
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            header.textLabel?.textColor = .appHeadLineColor
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionTitle = tableSections[indexPath.section]
            if sectionTitle == "Fixtures" {
                return 130
            }
            return 260

    }
}


extension TeamDetailsViewController: TeamDetailsViewProtocol {
    
    func showLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.indicator.center = self.view.center
            self.indicator.color = .appLoadingColor
            self.view.addSubview(self.indicator)
            self.indicator.startAnimating()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.indicator.stopAnimating()
            self?.indicator.removeFromSuperview()
        }
    }
    
    func displayTeamDetails(team: Team) {
        self.teamData = team
        filterPlayers(players: team.players ?? [])
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    if let headerView = self.teamTableView.tableHeaderView as? TeamHeaderView {
                        headerView.configure(with: team)
                    }
                    
                    self.teamTableView.reloadData()
                }
    }
    
    private func filterPlayers(players: [Player]) {
        let groupedDictionary = Dictionary(grouping: players) { player in
            return player.playerType ?? "Players"
        }
        tableSections = groupedDictionary.keys.sorted()
        playersBySection = tableSections.map { groupedDictionary[$0]! }
        tableSections.append("Fixtures")
    }
    
    func displayFixtures(fixtures: [Event]) {
        self.fixtures = fixtures
        DispatchQueue.main.async { [weak self] in
            self?.teamTableView.reloadData()
        }
    }
    
    func showError(message: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
}
