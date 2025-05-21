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
    /// Save a daily item
    /// - Parameter item: item to save
    /// - Returns: Result of operation, `Void` if successful, otherwise a `PersistentServiceError`
    func save(_ item: DailyItem) -> Result<Void, PersistentServiceError>

    /// Fetch Daily items between 2 dates
    /// - Parameters:
    ///   - startDate: From the date we retrieve the items
    ///   - endDate: Fetch items up to this date
    /// - Returns: All the DailyItems between these 2 dates, otherwise a `PersistentServiceError`
    func fetchRecentItems(from startDate: Date, to endDate: Date) -> Result<[DailyItem], PersistentServiceError>
}

enum PersistentServiceError: Error {
    case fetchFailed(Error)
    case saveFailed(Error)
}

final class PersistentService: PersistentServiceProtocol {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func save(_ item: DailyItem) -> Result<Void, PersistentServiceError> {
        context.insert(item)
        do {
            try context.save()
            Logger.persistent.debug("Saved daily item with date: \(item.date)")
            return .success(())
        } catch {
            Logger.persistent.error("Failed to save item with date \(item.date): \(error)")
            return .failure(.saveFailed(error))
        }
    }

    func fetchRecentItems(from startDate: Date, to endDate: Date) -> Result<[DailyItem], PersistentServiceError> {
        let descriptor = FetchDescriptor<DailyItem>(
            predicate: #Predicate {
                $0.date >= startDate && $0.date <= endDate
            }
        )

        do {
            let result = try context.fetch(descriptor)
            let count = result.count
            Logger.persistent.info("Fetched \(count) daily item\(count > 1 ? "s" : "") successfully")
            return .success(result)
        } catch {
            Logger.persistent.error("Failed to fetch daily items: \(error)")
            return .failure(.fetchFailed(error))
        }
    }
}
