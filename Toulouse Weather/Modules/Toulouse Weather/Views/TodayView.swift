//
//  TodayView.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 13/05/2025.
//

import SwiftUI

struct TodayView: View {
    var body: some View {
        VStack {
            SubTitle(title: "Today", trailingText: "8:00")
            row("Temperature", value: "19°C (feeling 18°C)")
            row("Wind", value: "ONO 11.1 km/h (gust 16.7 km/h)")
            row("Humidity", value: "71%")
            row("Atmospheric pressure", value: "1015 hPa")
            row("Visibility", value: "21 km")
            row("Precipitation", value: "0 mm/h")
        }
    }

    private func row(_ title: String, value: String?) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value ?? "-")
        }
    }
}

#Preview {
    TodayView()
}
