//
//  DateFormate.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 31/05/2026.
//


import Foundation

enum DateFormate {
    
    
    static let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        f.locale = Locale(identifier: "en_US_POSIX")
        f.calendar = Calendar(identifier: .gregorian)
        return f
    }()
    
    static func formatDate(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM dd"
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        }
        return dateString
    }
    
    static func today() -> String {
        formatter.string(from: Date())
    }
    
    static func daysAgo(_ n: Int) -> String {
        let d = Calendar.current.date(byAdding: .day, value: -n, to: Date()) ?? Date()
        return formatter.string(from: d)
    }
    
    static func daysAhead(_ n: Int) -> String {
        let d = Calendar.current.date(byAdding: .day, value: n, to: Date()) ?? Date()
        return formatter.string(from: d)
    }
}
