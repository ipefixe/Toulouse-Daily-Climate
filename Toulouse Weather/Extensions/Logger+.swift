//
//  Logger+.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 20/05/2025.
//

import OSLog

extension Logger {
    private static var identifier = Bundle.main.bundleIdentifier ?? "fr.ipefixe.toulouse-weather"

    static let persistent = Logger(subsystem: identifier, category: "PersistentService")
    static let scraping = Logger(subsystem: identifier, category: "ScrapingService")
    static let app = Logger(subsystem: identifier, category: "ToulouseWeatherApp")
}
