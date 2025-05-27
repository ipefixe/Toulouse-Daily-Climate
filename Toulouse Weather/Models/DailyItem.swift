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
    @Attribute(.unique)
    var date: Date
    var minTemperature: Double?
    var maxTemperature: Double?
    var avgTemperature: Double?
    var windSpeed: Double?
    var maxWindGust: Double?
    var sunshineDuration: String
    var precipitation: Double?
    var minPressure: Double?
    var maxPressure: Double?

    init(date: Date,
         minTemperature: Double?,
         maxTemperature: Double?,
         avgTemperature: Double?,
         windSpeed: Double?,
         maxWindGust: Double?,
         sunshineDuration: String,
         precipitation: Double?,
         minPressure: Double?,
         maxPressure: Double?) {
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
