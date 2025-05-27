//
//  String+.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 21/05/2025.
//

import Foundation

extension String {
    /// Date from a string "yyyy-MM-dd"
    var date: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.date(from: self)
    }

    /// TimeInterval from a string "8h 52m"
    var timeInterval: TimeInterval? {
        let splits = self.split(separator: " ")
        guard splits.count == 2 else {
            return nil
        }

        var seconds: Double = 0

        for item in splits {
            if item.contains("h"),
               let hourString = item.split(separator: "h").first {
                seconds += (Double(hourString) ?? 0) * 60 * 60
            } else if item.contains("min"),
                      let minuteString = item.split(separator: "min").first {
                seconds += (Double(minuteString) ?? 0) * 60
            }
        }

        return TimeInterval(integerLiteral: seconds)
    }
}
