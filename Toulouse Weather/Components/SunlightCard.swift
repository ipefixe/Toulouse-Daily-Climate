//
//  SunlightCard.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 12/05/2025.
//

import SwiftUI

struct SunlightCard: View {
    let timeInterval: TimeInterval?

    let minColor: Color
    let superiorColor: Color

    init(timeInterval: TimeInterval? = nil,
         minColor: Color = .black.opacity(0.4),
         superiorColor: Color = .yellow.opacity(0.4)) {
        self.timeInterval = timeInterval
        self.minColor = minColor
        self.superiorColor = superiorColor
    }

    private var duration: String {
        guard let timeInterval else {
            return "---"
        }

        let formatter = DateComponentsFormatter()

        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropAll
        formatter.allowedUnits = [.hour, .minute]

        return formatter.string(from: timeInterval) ?? "---"
    }

    var backgroundColor: Color {
        guard let timeInterval else {
            return Color.white.opacity(0.2)
        }

        return minColor.mix(
            with: superiorColor,
            by: timeInterval / TimeInterval(integerLiteral: 43200) // 12h
        )
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
                        Text(duration)
                            .fontWeight(.bold)
                    }
                }
        }
    }
}

#Preview {
    let timeInterval0 = TimeInterval(integerLiteral: 100)
    let timeInterval = TimeInterval(integerLiteral: 31920)
    let timeInterval1 = TimeInterval(integerLiteral: 43000)
    VStack {
        SunlightCard()
        SunlightCard(timeInterval: timeInterval0)
        SunlightCard(timeInterval: timeInterval)
        SunlightCard(timeInterval: timeInterval1)
    }.padding()
}
