//
//  PointTimelineCell.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 03/06/2026.
//

import UIKit

class PointTimelineCell: UITableViewCell {
    
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var runningScoreLabel: UILabel!
    @IBOutlet weak var pointsStackView: UIStackView!
    
    func configure(with model: PointByPointSet) {
        gameTitleLabel.text = "\(model.setNumber) — Game \(model.numberGame)"
        runningScoreLabel.text = "Score: \(model.score)"
        
        // Clear old structural views for recycled cells
        pointsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Dynamically add point layouts into stack view rows
        for point in model.points {
            let pointRow = UILabel()
            pointRow.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            pointRow.textColor = .label
            
            var rowText = "• Point \(point.numberPoint): \(point.score)"
            
            // Check for special game statuses safely
            if point.breakPoint != nil { rowText += "  [Break Point]" }
            else if point.setPoint != nil { rowText += "  [Set Point]" }
            else if point.matchPoint != nil { rowText += "  [Match Point]" }
            
            pointRow.text = rowText
            pointsStackView.addArrangedSubview(pointRow)
        }
    }
}
