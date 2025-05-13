//
//  ToulouseWeather.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 12/05/2025.
//

import SwiftSoup
import SwiftUI

struct ToulouseWeather: View {
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
        }
    }

    // MARK: - Privates

}

#Preview {
    ToulouseWeather()
}
