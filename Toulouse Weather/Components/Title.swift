//
//  Title.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 13/05/2025.
//

import SwiftUI

struct Title: View {
    let title: String
    let iconSystemName: String?

    init(title: String, iconSystemName: String? = nil) {
        self.title = title
        self.iconSystemName = iconSystemName
    }

    var body: some View {
        HStack(spacing: 10) {
            if let iconSystemName {
                Image(systemName: iconSystemName)
                    .renderingMode(.original)
                    .fontWeight(.heavy)
                    .imageScale(.large)
            }

            Text(title.uppercased())
                .fontWeight(.bold)
                .fontWidth(.expanded)
                .font(.title)
        }
    }
}

#Preview {
    VStack {
        Title(title: "Title")
        Title(title: "Title", iconSystemName: "rainbow")
    }
    .padding()
}
