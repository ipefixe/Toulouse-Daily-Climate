//
//  LastDaysView.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 13/05/2025.
//

import SwiftUI

struct LastDaysView: View {
    let dailyItems: [DailyItemViewData]

    var body: some View {
        if dailyItems.isEmpty {
            ProgressView("Loading...")
        } else {
            SubTitle(title: "Last \(dailyItems.count) days")

            VStack {
                header

                ForEach(dailyItems) { dailyItem in
                    row(for: dailyItem)
                }
            }
        }
    }

    private var header: some View {
        HStack {
            Spacer()
            Text("Temp. mean (max) (°C)")
                .frame(width: 100)
            Text("Wind (gust) (km/h)")
                .frame(width: 100)
            Text("Sunlight")
                .frame(width: 100)
            Text("Precipitation (mm)")
                .frame(width: 100)
        }
        .frame(height: 40.0)
    }

    private func row(for dailyItem: DailyItemViewData) -> some View {
        let minOpacity = 0.3
        let superiorOpacity = 0.9
        return HStack {
            Text(dailyItem.formattedDate)
            Spacer()
            DynamicInfoCard(
                mainValue: dailyItem.avgTemperature,
                secondaryValue: dailyItem.maxTemperature,
                superiorValue: 35.0,
                minColor: .lightViolet.opacity(minOpacity),
                superiorColor: .lightViolet.opacity(superiorOpacity)
            )
            DynamicInfoCard(
                mainValue: dailyItem.windSpeed,
                secondaryValue: dailyItem.maxWindGust,
                superiorValue: 60.0,
                minColor: .lightCottonCandy.opacity(minOpacity),
                superiorColor: .lightCottonCandy.opacity(superiorOpacity)
            )
            SunlightCard(
                timeInterval: dailyItem.sunshineDuration,
                minColor: .lightMalabar.opacity(minOpacity),
                superiorColor: .lightMalabar.opacity(superiorOpacity)
            )
            DynamicInfoCard(
                mainValue: dailyItem.precipitation,
                superiorValue: 30.0,
                minColor: .lightMentol.opacity(minOpacity),
                superiorColor: .lightMentol.opacity(superiorOpacity)
            )
        }
    }
}

#Preview {
    let emptyItem = DailyItemViewData(formattedDate: "2025/10/23")
    let minItem = DailyItemViewData(
        formattedDate: "2025/10/22",
        maxTemperature: 0,
        avgTemperature: 0,
        windSpeed: 0,
        maxWindGust: 0,
        sunshineDuration: TimeInterval(0),
        precipitation: 0
    )
    let avgItem = DailyItemViewData(
        formattedDate: "2025/10/21",
        maxTemperature: 0,
        avgTemperature: 17.5,
        windSpeed: 30.0,
        maxWindGust: 125.0,
        sunshineDuration: TimeInterval(18500),
        precipitation: 15.0
    )
    let maxItem = DailyItemViewData(
        formattedDate: "2025/10/20",
        maxTemperature: 66.0,
        avgTemperature: 35.0,
        windSpeed: 60.0,
        maxWindGust: 125.0,
        sunshineDuration: TimeInterval(43200),
        precipitation: 30.0
    )

    VStack {
        LastDaysView(dailyItems: [])
        LastDaysView(dailyItems: [emptyItem, minItem, avgItem, maxItem])
    }
    .padding()
}
