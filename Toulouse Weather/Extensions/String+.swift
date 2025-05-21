//
//  String+.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 21/05/2025.
//

import Foundation

extension String {
    var date: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.date(from: self) ?? .distantPast
    }
}
