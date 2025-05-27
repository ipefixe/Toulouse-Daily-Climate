//
//  ToulouseWeatherViewModel.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 16/05/2025.
//

import Foundation
import OSLog
import SwiftData

@MainActor
class ToulouseWeatherViewModel: ObservableObject {
    @Published private var dailyItems = [DailyItem]()
    var lastDaysViewData: [DailyItemViewData] {
        dailyItems.map { DailyItemViewData(from: $0) }
    }

    private let scraperService: WebScraperServiceProtocol
    private let persistentService: PersistentServiceProtocol

    init(scraperService: WebScraperServiceProtocol,
         persistentService: PersistentServiceProtocol) {
        self.scraperService = scraperService
        self.persistentService = persistentService
    }

    /// Load DailyItems
    /// - Parameters:
    ///   - start: from `start` days ago
    ///   - end: to `end` days ago
    func loadData(from start: Int, to end: Int) async {
        guard let startDate = Date.now.add(day: -start),
              let endDate = Date.now.add(day: -end) else {
            return
        }

        try! await Task.sleep(for: .seconds(1)) // TODO: To remove

        let expectedDays = start - end

        do {
            Logger.app.info("Load DailyItems from \(startDate.shortDate) to \(endDate.shortDate))")
            var items = try persistentService.fetchDailyItems(from: startDate, to: endDate)
            if items.count != expectedDays {
                Logger.app.info("Missing data (\(items.count) found, \(expectedDays) expected), scraping data...")
                let scrapedItems = try await scraperService.fetchDailies(from: startDate, to: endDate)
                let mappedItems = scrapedItems.map(DailyItemMapper.map)
                try persistentService.save(mappedItems)
                items = try persistentService.fetchDailyItems(from: startDate, to: endDate)
            }
            dailyItems = items
        } catch {
            print(error.localizedDescription)
        }
    }
}
