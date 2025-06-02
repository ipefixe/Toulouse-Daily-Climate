//
//  Date+.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 20/05/2025.
//

import Foundation

extension Date {
    var shortDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: self)
    }

    /// Adding months to the current date
    /// - Parameter months: number of month to add
    /// - Returns: A new date with the number of months added
    func add(month: Int) -> Date? {
        Calendar.current.date(byAdding: .month, value: month, to: self)
    }

    /// Adding days to the current date
    /// - Parameter day: number of day to add
    /// - Returns: A new date with the number of days added
    func add(day: Int) -> Date? {
        Calendar.current.date(byAdding: .day, value: day, to: self)
    }

    // MARK: - Scraper Specific

    /// Format a date for a specific mode
    /// - Parameter mode: Mode (daily or hourly)
    /// - Returns: The formatted date
    func format(for mode: WebScraperService.Mode) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = mode == .daily ? "yyyy-MM" : "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }

    /// To make it easier to calculate the months to fetch, we modify date to a specific day (the first day of the month)
    /// 2024-10-23 -> 2024-10-01
    var normalizedDate: Date? {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current

        var components = calendar.dateComponents([.year, .month], from: self)
        components.day = 1
        components.hour = 12
        components.minute = 0
        components.second = 0
        return calendar.date(from: components)
    }
}
