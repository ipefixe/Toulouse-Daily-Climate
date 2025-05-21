//
//  ToulouseWeather.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 12/05/2025.
//

import SwiftSoup
import SwiftUI

struct ToulouseWeather: View {
    private let viewModel: ToulouseWeatherViewModel

    init(viewModel: ToulouseWeatherViewModel = ToulouseWeatherViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Title(
                    title: "Toulouse Weather",
                    iconSystemName: "cloud.sun.fill"
                )

                TodayView()

                Last7DaysView()

                Spacer()
            }
            .padding()
            .onAppear {
                Task {
                    await populateView()
                }
            }
        }
    }

    // MARK: - Privates

    private func populateView() async {
        guard let startDate = Date.now.add(day: -150),
              let endDate = Date.now.add(day: -1) else {
            return
        }

        do {
            try await WebScraperService().fetchDailies(from: startDate, to: endDate)
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ToulouseWeather()
}
