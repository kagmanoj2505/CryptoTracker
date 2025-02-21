//
//  String+Extension.swift
//  EquityCoinRanking
//
//  Created by Kag Manoj on 19/2/25.
//

import Foundation
extension String {
    func fileExtension() -> String {
        return URL(fileURLWithPath: self).pathExtension
    }
    
    func formattedPrice() -> String {
        guard let priceValue = Double(self) else { return "N/A" }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency  // Use currency format
        formatter.currencySymbol = "$"  // Set currency symbol to "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: priceValue)) ?? "N/A"
    }
    
    var removingHTMLOccurences: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
