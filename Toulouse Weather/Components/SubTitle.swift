//
//  SubTitle.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 13/05/2025.
//

import SwiftUI

struct SubTitle: View {
    let title: String
    let trailingText: String?

    @Environment(\.colorScheme) private var colorScheme

    init(title: String, trailingText: String? = nil) {
        self.title = title
        self.trailingText = trailingText
    }

    private var lineColor: Color {
        colorScheme == .dark ? .white : .black
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text(title.uppercased())
                    .font(.title2)
                    .fontWidth(.expanded)
                if let trailingText {
                    Text("(\(trailingText))")
                        .font(.caption)
                }
            }
            LinearGradient(
                colors: [lineColor, lineColor, .clear],
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(height: 1)
        }
    }
}

#Preview {
    VStack {
        SubTitle(title: "Title")
        SubTitle(title: "Title", trailingText: "With a trailing text")
    }
    .padding()
}
