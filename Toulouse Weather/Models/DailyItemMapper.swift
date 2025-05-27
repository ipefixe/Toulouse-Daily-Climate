//
//  DailyItemMapper.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 21/05/2025.
//

protocol DailyItemMapperProtocol {
    static func map(_ item: DailyItemDTO) -> DailyItem
}

final class DailyItemMapper: DailyItemMapperProtocol {
    static func map(_ item: DailyItemDTO) -> DailyItem {
        DailyItem(
            date: item.date,
            minTemperature: Double(item.minTemperature),
            maxTemperature: Double(item.maxTemperature),
            avgTemperature: Double(item.avgTemperature),
            windSpeed: Double(item.windSpeed),
            maxWindGust: Double(item.maxWindGust),
            sunshineDuration: item.sunshineDuration,
            precipitation: Double(item.precipitation),
            minPressure: Double(item.minPressure),
            maxPressure: Double(item.maxPressure)
        )
    }
}
