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
    
        var goalkeepers: [Player] = []
        var defenders: [Player] = []
        var midfielders: [Player] = []
        var forwards: [Player] = []
        
        private let indicator = UIActivityIndicatorView(style: .large)
        let tableSections = ["Goalkeepers", "Defenders", "Midfielders", "Forwards", "Fixtures"]
    
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
        if section == tableSections.count - 1 {
                    return fixtures.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == tableSections.count - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FixtureTableViewCell", for: indexPath) as! FixtureTableViewCell
            let match = fixtures[indexPath.row]
            cell.configure(with: match)
            return cell
        }
        else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersRowTableViewCell", for: indexPath) as! PlayersRowTableViewCell
                    cell.selectionStyle = .none
                    
                    switch indexPath.section {
                    case 0:
                        cell.configure(with: goalkeepers)
                    case 1:
                        cell.configure(with: defenders)
                    case 2:
                        cell.configure(with: midfielders)
                    case 3:
                        cell.configure(with: forwards)
                    default:
                        break
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
            header.textLabel?.textColor = UIColor(red: 0.0/255.0, green: 194.0/255.0, blue: 248.0/255.0, alpha: 1.0)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.section == tableSections.count - 1 {
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
            self.indicator.color = .cyan 
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
            goalkeepers = players.filter { $0.playerType == "Goalkeepers" }
            defenders = players.filter { $0.playerType == "Defenders" }
            midfielders = players.filter { $0.playerType == "Midfielders" }
            forwards = players.filter { $0.playerType == "Forwards" }
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
