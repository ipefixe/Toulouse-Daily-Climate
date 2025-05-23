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
    private let modelContainer: ModelContainer

    init() {
        do {
            modelContainer = try ModelContainer(for: DailyItem.self)
        } catch {
            fatalError("Failed to create ModelContainer")
        }
    }

    var body: some Scene {
        WindowGroup {
            let scraperService = WebScraperService()
            let persistentService = PersistentService(context: modelContainer.mainContext)
            let viewModel = ToulouseWeatherViewModel(scraperService: scraperService,
                                                     persistentService: persistentService)
            ToulouseWeather(viewModel: viewModel)
        }
        .modelContainer(modelContainer)
    }
}
