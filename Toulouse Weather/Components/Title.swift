//
//  Title.swift
//  Toulouse Weather
//
//  Created by Kevin Boulala on 13/05/2025.
//

import SwiftUI

struct Title: View {
    @State var title: String = ""
    @State var iconSystemName: String = ""

    var body: some View {
        HStack(spacing: 10) {
            if !iconSystemName.isEmpty {
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
