//
//  DailyItemDTO.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 21/05/2025.
//

import Foundation

struct DailyItemDTO: Sendable {
    var date: Date
    var minTemperature: String
    var maxTemperature: String
    var avgTemperature: String
    var windSpeed: String
    var maxWindGust: String
    var sunshineDuration: String
    var precipitation: String
    var minPressure: String
    var maxPressure: String
}
