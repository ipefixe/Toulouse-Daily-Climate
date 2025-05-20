//
//  DailyItem.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 16/05/2025.
//

import Foundation
import SwiftData

@Model
class DailyItem {
    var date: String
    var minTemperature: String
    var maxTemperature: String
    var avgTemperature: String
    var windSpeed: String
    var maxWindGust: String
    var sunshineDuration: String
    var precipitation: String
    var minPressure: String
    var maxPressure: String

    var dateFormatted: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.date(from: date) ?? Date.distantPast
    }

    init(date: String,
         minTemperature: String,
         maxTemperature: String,
         avgTemperature: String,
         windSpeed: String,
         maxWindGust: String,
         sunshineDuration: String,
         precipitation: String,
         minPressure: String,
         maxPressure: String) {
        self.date = date
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
        self.avgTemperature = avgTemperature
        self.windSpeed = windSpeed
        self.maxWindGust = maxWindGust
        self.sunshineDuration = sunshineDuration
        self.precipitation = precipitation
        self.minPressure = minPressure
        self.maxPressure = maxPressure
    }
}
