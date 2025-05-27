//
//  ToulouseWeather.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 12/05/2025.
//

import SwiftData
import SwiftSoup
import SwiftUI

struct ToulouseWeather: View {
    @ObservedObject private var viewModel: ToulouseWeatherViewModel

    init(viewModel: ToulouseWeatherViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Title(
                    title: "Toulouse Weather",
                    iconSystemName: "cloud.sun.fill"
                )

                // TodayView()

                LastDaysView(dailyItems: viewModel.lastDaysViewData)

                Spacer()
            }
            .padding()
            .onAppear {
                Task {
                    await viewModel.loadData(from: 15, to: 1)
                }
            }
        }
    }
}

#Preview {
    let scraperService = MockWebScraperService()
    let persistentService = MockPersistentService()

    let viewModel = ToulouseWeatherViewModel(scraperService: scraperService, persistentService: persistentService)

    ToulouseWeather(viewModel: viewModel)
        .padding()
}
