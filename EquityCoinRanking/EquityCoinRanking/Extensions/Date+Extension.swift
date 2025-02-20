//
//  Date+Extension.swift
//  EquityCoinRanking
//
//  Created by Kag Manoj on 20/2/25.
//

import Foundation

extension Date {
    
    /// Initialize a `Date` from a Unix timestamp (seconds-based).
    init(cryptoTimestamp: TimeInterval) {
        self = Date(timeIntervalSince1970: cryptoTimestamp)
    }
    
    /// Short date format (e.g., "02/20/25")
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    /// Convert Date to Short String (MM/dd/yy)
    func asShortDateString() -> String {
        return shortFormatter.string(from: self)
    }
    
    /// Convert Date to Full Format (e.g., "Feb 20, 2025")
    func asFullDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: self)
    }
    
}
/*
let timestamp = 1330214400.0 // ListedAt from JSON
let listedDate = Date(cryptoTimestamp: timestamp)

print("Short Date: \(listedDate.asShortDateString())") // Example: "02/25/12"
print("Full Date: \(listedDate.asFullDateString())")   // Example: "Feb 25, 2012"
*/
