//
//  LeaguesDetailsUICollectionViewDataSourceExtention.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 01/06/2026.
//

import Foundation
import UIKit
extension LeaguesDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case upcomingCollectionView:
            return upcomingEvents.count
        case latestEventsCollectionView:
            return latestEvents.count
        case teamsCollectionView:
            return teams.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case upcomingCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingEventCell", for: indexPath) as! UpcomingEventCell
            let event = upcomingEvents[indexPath.item]
            cell.configure(with: event)
            return cell
            
        case latestEventsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestEventCell", for: indexPath) as! LatestEventCell
            let event = latestEvents[indexPath.item]
            cell.configure(with: event)
            return cell
            
        case teamsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! TeamCell
            let team = teams[indexPath.item]
            cell.configure(with: team)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}
