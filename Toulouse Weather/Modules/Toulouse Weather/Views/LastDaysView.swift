//
//  LastDaysView.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 13/05/2025.
//

import SwiftUI

struct LastDaysView: View {
    @ObservedObject var viewModel: ToulouseWeatherViewModel

    var body: some View {
        if viewModel.lastDaysViewData.isEmpty {
            ProgressView("Loading...")
        } else {
            SubTitle(title: "Last \(viewModel.lastDaysViewData.count) days")

            VStack {
                // header
                HStack {
                    Spacer()
                    Text("Temp. mean (max) (°C)")
                        .frame(width: 100)
                    Text("Wind (guts) (km/h)")
                        .frame(width: 100)
                    Text("Sunlight")
                        .frame(width: 100)
                    Text("Precipitation (mm)")
                        .frame(width: 100)
                }
                .frame(height: 40.0)

                // content
                VStack {
                    ForEach(viewModel.lastDaysViewData) { item in
                        HStack {
                            Text(item.formattedDate)
                            Spacer()
                            DynamicInfoCard(
                                mainValue: item.avgTemperature,
                                secondaryValue: item.maxTemperature
                            )
                            DynamicInfoCard(
                                mainValue: item.windSpeed,
                                secondaryValue: item.maxWindGust,
                                superiorValue: 50.0,
                                minColor: Color.gray,
                                superiorColor: Color.teal
                            )
                            SunlightCard(timeInterval: item.sunshineDuration)
                            DynamicInfoCard(
                                mainValue: item.precipitation,
                                superiorValue: 20.0,
                                minColor: Color.gray,
                                superiorColor: Color.blue
                            )
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    // LastDaysView(viewModel: [])
}
