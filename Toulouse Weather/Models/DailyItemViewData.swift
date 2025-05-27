//
//  DailyItemViewData.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 26/05/2025.
//

import Foundation

struct DailyItemViewData: Identifiable {
    var id: String { formattedDate }
    var formattedDate: String
    var minTemperature: Double?
    var maxTemperature: Double?
    var avgTemperature: Double?
    var windSpeed: Double?
    var maxWindGust: Double?
    var sunshineDuration: TimeInterval?
    var precipitation: Double?
    var minPressure: Double?
    var maxPressure: Double?
}

extension DailyItemViewData {
    init(from model: DailyItem) {
        self.formattedDate = model.date.shortDate
        self.minTemperature = model.minTemperature
        self.maxTemperature = model.maxTemperature
        self.avgTemperature = model.avgTemperature
        self.windSpeed = model.windSpeed
        self.maxWindGust = model.maxWindGust
        self.sunshineDuration = model.sunshineDuration.timeInterval
        self.precipitation = model.precipitation
        self.minPressure = model.minPressure
        self.maxPressure = model.maxPressure
    }
}
