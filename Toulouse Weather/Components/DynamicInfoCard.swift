//
//  DynamicInfoCard.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 12/05/2025.
//

import SwiftUI

struct DynamicInfoCard: View {
    let mainValue: Double?
    let secondaryValue: Double?

    let minValue: Double
    let superiorValue: Double

    let minColor: Color
    let superiorColor: Color

    var backgroundColor: Color {
        guard let mainValue else {
            return Color.white.opacity(0.2)
        }

        return minColor.mix(
            with: superiorColor,
            by: mainValue / superiorValue
        )
    }

    init(mainValue: Double? = nil,
         secondaryValue: Double? = nil,
         minValue: Double = 0.0,
         superiorValue: Double = 25.0,
         minColor: Color = .blue.opacity(0.4),
         superiorColor: Color = .red.opacity(0.4)) {
        self.mainValue = mainValue
        self.secondaryValue = secondaryValue
        self.minValue = minValue
        self.superiorValue = superiorValue
        self.minColor = minColor
        self.superiorColor = superiorColor
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(.black)
                .frame(width: 100.0, height: 40.0)
            RoundedRectangle(cornerRadius: 10.0)
                .fill(backgroundColor)
                .stroke(Color.gray, lineWidth: 1.0)
                .frame(width: 100.0, height: 40.0)
                .overlay {
                    HStack {
                        if let mainValue {
                            Text("\(mainValue.formatted())")
                                .fontWeight(.bold)
                        } else {
                            Text("---")
                        }
                        if let secondaryValue {
                            Text("(\(secondaryValue.formatted()))")
                        }
                    }
                }
        }
    }
}

#Preview {
    VStack {
        DynamicInfoCard()
        DynamicInfoCard(mainValue: 0)
        DynamicInfoCard(mainValue: 12.7, secondaryValue: 16.6)
        DynamicInfoCard(mainValue: 20)
        DynamicInfoCard(mainValue: 23.5)
        DynamicInfoCard(mainValue: 25)
        DynamicInfoCard(mainValue: 32, secondaryValue: 45.6)
    }.padding()
}
