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
            minTemperature: item.minTemperature,
            maxTemperature: item.maxTemperature,
            avgTemperature: item.avgTemperature,
            windSpeed: item.windSpeed,
            maxWindGust: item.maxWindGust,
            sunshineDuration: item.sunshineDuration,
            precipitation: item.precipitation,
            minPressure: item.minPressure,
            maxPressure: item.maxPressure
        )
    }
}
