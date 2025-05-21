//
//  WebScraperService.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 16/05/2025.
//

import Foundation
import OSLog
import SwiftSoup

protocol WebScraperServiceProtocol {
    /// Fetch daily weather between two dates
    /// - Parameters:
    ///   - startDate: The starting date
    ///   - endDate: The ending date
    /// - Returns: A list of `DailyItemDTO`
    func fetchDailies(from startDate: Date, to endDate: Date) async throws -> [DailyItemDTO]
}

enum ScraperError: LocalizedError {
    case invalidURL(String)
    case invalidData(URL)
    case tableNotFound
    
    var errorDescription: String {
        return switch self {
        case .invalidURL(let urlString): "The URL generated is invalid: \(urlString)"
        case .invalidData(let url): "Invalid HTML data received for: \(url.absoluteString)"
        case .tableNotFound: "Failed to find table with 'toprint' class"
        }
    }
}

final class WebScraperService: WebScraperServiceProtocol {
    // MARK: - Enums
    
    private enum URLPlaceHolders: String {
        case mode = "{MODE}"
        case date = "{DATE}"
    }
    
    enum Mode: String {
        case daily = "journalier"
        case hourly = "horaire"
    }
    
    // MARK: - Privates
    
    private let baseURLTemplate = "https://prevision-meteo.ch/climat/\(URLPlaceHolders.mode.rawValue)/toulouse-blagnac/\(URLPlaceHolders.date.rawValue)"
    
    /// Build a list of URLs for each months to fetch
    /// - Returns: List of URLs
    private func getMonthsToFetch(from startDate: Date, to endDate: Date) -> [String] {
        guard let start = startDate.normalizedDate,
              let end = endDate.normalizedDate else {
            Logger.scraping.error("Can't 'normalized' a date. Start Date = \(startDate), End Date = \(endDate))")
            return []
        }
        
        var monthsToFetch = [String]()
        var date = start
        
        while date <= end {
            monthsToFetch.append(date.format(for: .daily))
            date = date.add(month: 1) ?? Date.distantFuture
        }
        
        return monthsToFetch
            .map {
                baseURLTemplate
                    .replacingOccurrences(
                        of: URLPlaceHolders.mode.rawValue,
                        with: Mode.daily.rawValue
                    )
                    .replacingOccurrences(
                        of: URLPlaceHolders.date.rawValue,
                        with: $0
                    )
            }
    }
    
    private func downloadHTML(from url: URL) async throws -> String {
        var request = URLRequest(url: url)
        request.setValue("Mozilla/5.0 (iPhone; CPU iPhone OS 17_7_2 like Mac OS X)", forHTTPHeaderField: "User-Agent")
        let (data, _) = try await URLSession.shared.data(for: request)
        
        guard let html = String(data: data, encoding: .utf8) else {
            throw ScraperError.invalidData(url)
        }
        
        Logger.scraping.debug("Download succeeded: \(url.absoluteString)")
        
        return html
    }
    
    private func parseDailies(_ html: String) throws -> [DailyItemDTO] {
        let document = try SwiftSoup.parse(html)
        
        guard let table = try document.select("div.toprint table").first() else {
            throw ScraperError.tableNotFound
        }
        
        let rows = try table.select("tbody tr")
        return try rows.array().compactMap { row -> DailyItemDTO? in
            let columns = try row.select("td")
            guard columns.size() == 10,
                  let dateHref = try columns[0].select("a[href]").first(),
                  let dateString = try dateHref.attr("href").split(separator: "/").last,
                  !dateString.isEmpty else {
                Logger.scraping.warning("Row skipped because of a missing date: \(row)")
                return nil
            }
            
            let minTemperature = try columns[1].text()
            let maxTemperature = try columns[2].text()
            let avgTemperature = try columns[3].text()
            let windSpeed = try columns[4].text()
            let maxWindGust = try columns[5].text()
            let sunshineDuration = try columns[6].text()
            let precipitation = try columns[7].text()
            let minPressure = try columns[8].text()
            let maxPressure = try columns[9].text()
            
            Logger.scraping.debug("Parse succeeded for row: \(dateString)")
            
            return DailyItemDTO(
                dateString: "\(dateString)",
                minTemperature: minTemperature,
                maxTemperature: maxTemperature,
                avgTemperature: avgTemperature,
                windSpeed: windSpeed,
                maxWindGust: maxWindGust,
                sunshineDuration: sunshineDuration,
                precipitation: precipitation,
                minPressure: minPressure,
                maxPressure: maxPressure
            )
        }
    }
    
    // MARK: - Publics
        
    func fetchDailies(from startDate: Date, to endDate: Date) async throws -> [DailyItemDTO] {
        let urlsString = getMonthsToFetch(from: startDate, to: endDate)
        Logger.scraping.info("Months to fetch: \(urlsString)")
        
        var weatherData = [DailyItemDTO]()
        
        try await withThrowingTaskGroup(of: [DailyItemDTO].self) { group in
            
            for urlString in urlsString {
                guard let url = URL(string: urlString) else {
                    Logger.scraping.warning("Skip fetching data: \(ScraperError.invalidURL(urlString))")
                    continue
                }
                
                group.addTask {
                    do {
                        let html = try await self.downloadHTML(from: url)
                        return try self.parseDailies(html)
                    } catch {
                        Logger.scraping.warning("Failed to fetch or parse data from \(urlString): \(error)")
                        return []
                    }
                }
            }
            
            for try await items in group {
                weatherData.append(contentsOf: items)
            }
        }
        
        return weatherData
    }
}
