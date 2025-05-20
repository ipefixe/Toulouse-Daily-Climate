//
//  Toulouse_WeatherApp.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 12/05/2025.
//

import SwiftData
import SwiftUI

@main
struct Toulouse_WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            ToulouseWeather()
        }
        .modelContainer(for: DailyItem.self)
    }
}
