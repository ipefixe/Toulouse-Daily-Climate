//
//  Last7DaysView.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 13/05/2025.
//

import SwiftUI

struct Last7DaysView: View {
    var body: some View {
        SubTitle(title: "Last 7 days")

        VStack {
            // header
            HStack {
                Spacer()
                Text("Temp. mean (max) (°C)")
                    .frame(width: 100)
                Text("Wind (km/h)")
                    .frame(width: 100)
                Text("Sunlight")
                    .frame(width: 100)
                Text("Precipitation (mm)")
                    .frame(width: 100)
            }
            .frame(height: 40.0)

            // content
            HStack {
                Text("Thursday, April 4th 2030")
                Spacer()
                DynamicInfoCard(mainValue: 17.4)
                DynamicInfoCard(
                    mainValue: 18.5,
                    superiorValue: 50.0,
                    minColor: Color.gray,
                    superiorColor: Color.teal
                )
                SunlightCard()
                DynamicInfoCard(
                    mainValue: 17.0,
                    superiorValue: 20.0,
                    minColor: Color.yellow,
                    superiorColor: Color.blue
                )
            }

            HStack {
                Text("Thursday, April 4th 2030")
                Spacer()
                DynamicInfoCard(mainValue: 0, secondaryValue: 0)
                DynamicInfoCard(
                    mainValue: 0,
                    superiorValue: 50.0,
                    minColor: Color.gray,
                    superiorColor: Color.teal
                )
                SunlightCard()
                DynamicInfoCard(
                    mainValue: 0,
                    superiorValue: 20.0,
                    minColor: Color.yellow,
                    superiorColor: Color.blue
                )
            }

            HStack {
                Text("Thursday, April 4th 2030")
                Spacer()
                DynamicInfoCard(mainValue: 25.0, secondaryValue: 27.5)
                DynamicInfoCard(
                    mainValue: 50.0,
                    superiorValue: 50.0,
                    minColor: Color.gray,
                    superiorColor: Color.mint
                )
                SunlightCard()
                DynamicInfoCard(
                    mainValue: 20.0,
                    superiorValue: 20.0,
                    minColor: Color.yellow,
                    superiorColor: Color.blue
                )
            }
        }
    }
}

#Preview {
    Last7DaysView()
}
