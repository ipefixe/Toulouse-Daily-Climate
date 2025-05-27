//
//  PersistentService.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 20/05/2025.
//

import Foundation
import OSLog
import SwiftData

protocol PersistentServiceProtocol {
    /// Save DailyItems
    /// - Parameter items: items to save
    /// - Returns: Result of operation, `Void` if successful, otherwise throw a `PersistentServiceError` exception
    func save(_ items: [DailyItem]) throws

    /// Fetch Daily items between 2 dates
    /// - Parameters:
    ///   - startDate: From the date we retrieve the items
    ///   - endDate: Fetch items up to this date
    /// - Returns: All the DailyItems between these 2 dates, otherwise throw a `PersistentServiceError`exception
    func fetchDailyItems(from startDate: Date, to endDate: Date) throws -> [DailyItem]
}

enum PersistentServiceError: LocalizedError {
    case fetchFailed(Error)
    case saveFailed(Int, Error)

    var errorDescription: String {
        return switch self {
        case .fetchFailed(let error): "Failed to fetch DailyItems: \(error)"
        case .saveFailed(let count, let error): "Failed to save \(count) dailyItems: \(error)"
        }
    }
}

final class PersistentService: PersistentServiceProtocol {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func save(_ items: [DailyItem]) throws {
        guard !items.isEmpty else {
            Logger.persistent.debug("No DailyItem to save")
            return
        }

        // Sort items to find start and end dates
        let itemsSorted = items.sorted { $0.date < $1.date }
        guard let firstItem = itemsSorted.first,
              let lastItem = itemsSorted.last else { return }
        let startDate = firstItem.date
        let endDate = lastItem.date

        // Fetch all items between these 2 dates
        let itemsSaved: [DailyItem]
        do {
            itemsSaved = try fetchDailyItems(from: startDate, to: endDate)
        } catch {
            throw PersistentServiceError.fetchFailed(error)
        }
        let datesSaved = Set(itemsSaved.map { $0.date })

        // Filter out items already saved
        let itemsToSave = itemsSorted.filter { !datesSaved.contains($0.date) }

        // Insert remaining new items
        itemsToSave.forEach { context.insert($0) }

        // Save (only if there are changes)
        guard context.hasChanges else {
            Logger.persistent.debug("All \(itemsToSave.count) DailyItems already exist. There is no unsaved changes")
            return
        }
        do {
            try context.save()
            Logger.persistent.info("Saved \(itemsToSave.count) DailyItems")
        } catch {
            throw PersistentServiceError.saveFailed(itemsToSave.count, error)
        }
    }

    func fetchDailyItems(from startDate: Date, to endDate: Date) throws -> [DailyItem] {
        let descriptor = FetchDescriptor<DailyItem>(
            predicate: #Predicate {
                $0.date >= startDate && $0.date <= endDate
            }
        )

        do {
            let result = try context.fetch(descriptor)
            let count = result.count
            let from = startDate.shortDate
            let to = endDate.shortDate
            Logger.persistent.info("Fetched \(count) DailyItem\(count > 1 ? "s" : "") successfully (from \(from) to \(to))")
            return result
        } catch {
            throw PersistentServiceError.fetchFailed(error)
        }
    }
}

// TODO: Where to place this code?
final class MockPersistentService: PersistentServiceProtocol {
    func save(_ items: [DailyItem]) throws {}

    func fetchDailyItems(from startDate: Date, to endDate: Date) throws -> [DailyItem] {
        guard let end = Date.now.add(day: -1),
              let start = Date.now.add(day: -2) else { return [] }

        let dailyItemsDTO = [
            DailyItemDTO(
                date: start,
                minTemperature: "14.6",
                maxTemperature: "28",
                avgTemperature: "22.5",
                windSpeed: "24.1",
                maxWindGust: "33.3",
                sunshineDuration: "11h 42min",
                precipitation: "0",
                minPressure: "1014.1",
                maxPressure: "1017.6"
            ),
            DailyItemDTO(
                date: end,
                minTemperature: "13.7",
                maxTemperature: "24.8",
                avgTemperature: "19.6",
                windSpeed: "18.5",
                maxWindGust: "26.3",
                sunshineDuration: "10h 33min",
                precipitation: "6.8",
                minPressure: "106.8",
                maxPressure: "1011.9"
            )
        ]
        return dailyItemsDTO.map { DailyItemMapper.map($0) }
    }
}
