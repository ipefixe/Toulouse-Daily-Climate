//
//  DynamicInfoCard.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 12/05/2025.
//

import SwiftUI

struct DynamicInfoCard: View {
    @State var mainValue: Double?
    @State var secondaryValue: Double?

    @State var minValue: Double = 0.0
    @State var superiorValue: Double = 25.0

    @State var minColor: Color = .blue
    @State var superiorColor: Color = .red

    var backgroundColor: Color {
        guard let mainValue else {
            return Color.white.opacity(0.2)
        }

        return minColor.mix(
            with: superiorColor,
            by: mainValue / superiorValue
        )
    }

    var body: some View {
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
