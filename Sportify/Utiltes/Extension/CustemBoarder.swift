//
//  CustemBoarder.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 31/05/2026.
//

import Foundation
import UIKit

extension UIView {
    func addCustomCardBorders(color: UIColor, thickness: CGFloat, radius: CGFloat) {
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        
       
        let shapeLayer: CAShapeLayer
        if let existingLayer = self.layer.sublayers?.first(where: { $0.name == "CustomCardBorder" }) as? CAShapeLayer {
            shapeLayer = existingLayer
        } else {
            shapeLayer = CAShapeLayer()
            shapeLayer.name = "CustomCardBorder"
            shapeLayer.strokeColor = color.cgColor
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.lineWidth = thickness
            shapeLayer.lineCap = .round
            self.layer.addSublayer(shapeLayer)
        }
        
        let path = UIBezierPath()
        let inset: CGFloat = thickness / 2
        let w = bounds.width  // Use bounds instead of frame for accuracy inside layers
        let h = bounds.height
        
        // --- 1. Top-Left & Partial Top Border ---
        path.move(to: CGPoint(x: radius * 2, y: inset))
        path.addLine(to: CGPoint(x: radius + inset, y: inset))
        path.addArc(withCenter: CGPoint(x: radius + inset, y: radius + inset),
                    radius: radius,
                    startAngle: CGFloat.pi * 1.5,
                    endAngle: CGFloat.pi,
                    clockwise: false)
        path.addLine(to: CGPoint(x: inset, y: radius * 2))
        
        // --- 2. Bottom-Right & Partial Bottom Border ---
        path.move(to: CGPoint(x: w - (radius * 2), y: h - inset))
        path.addLine(to: CGPoint(x: w - radius - inset, y: h - inset))
        path.addArc(withCenter: CGPoint(x: w - radius - inset, y: h - radius - inset),
                    radius: radius,
                    startAngle: CGFloat.pi * 0.5,
                    endAngle: 0,
                    clockwise: false)
        path.addLine(to: CGPoint(x: w - inset, y: h - (radius * 2)))
        
        // Update the path to match the final size
        shapeLayer.path = path.cgPath
    }
}
