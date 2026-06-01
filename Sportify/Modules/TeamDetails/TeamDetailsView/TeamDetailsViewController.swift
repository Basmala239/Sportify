//
//  TeamDetailsViewController.swift
//  Sportify
//
//  Created by Esraa Ehab on 30/05/2026.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    @IBOutlet weak var teamTableView: UITableView!
    
    let playerSections = ["Goalkeepers", "Defenders", "Midfielders", "Forwards"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewHeader()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    private func setupTableViewHeader() {
        let headerView = TeamHeaderView(frame: CGRect(x: 0, y: 0, width: teamTableView.frame.width, height: 170))
            teamTableView.tableHeaderView = headerView
    }
    
    func setupTableView(){
        let nib =  UINib(nibName: "PlayersRowTableViewCell", bundle: nil)
        teamTableView.register(nib, forCellReuseIdentifier: "PlayersRowTableViewCell")
        
        teamTableView.dataSource = self
        teamTableView.delegate = self
        
        teamTableView.rowHeight = 240
        teamTableView.separatorStyle = .none
        
        if #available(iOS 15.0, *) {
           teamTableView.sectionHeaderTopPadding = 40
        }
    }
}


extension TeamDetailsViewController : UITableViewDataSource , UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        playerSections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersRowTableViewCell", for: indexPath) as! PlayersRowTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return playerSections[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView{
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            header.textLabel?.textColor = .cyan
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
