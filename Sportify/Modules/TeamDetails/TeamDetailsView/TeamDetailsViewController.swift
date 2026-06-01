//
//  TeamDetailsViewController.swift
//  Sportify
//
//  Created by Esraa Ehab on 30/05/2026.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    @IBOutlet weak var teamTableView: UITableView!
    
    let tableSections = ["Goalkeepers", "Defenders", "Midfielders", "Forwards", "Fixtures"]
    
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
                    return 3 
                }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == tableSections.count - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FixtureTableViewCell", for: indexPath) as! FixtureTableViewCell
            return cell
        }
        else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersRowTableViewCell", for: indexPath) as! PlayersRowTableViewCell
        cell.selectionStyle = .none
        return cell
       }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableSections[section]
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.section == tableSections.count - 1 {
                return 130 // ارتفاع كارت المباراة (ممكن تكبريه أو تصغريه حسب الديزاين بتاعك)
            }
            return 260 // الارتفاع اللي كنا ظابطينه لكروت اللعيبة
        }
}
