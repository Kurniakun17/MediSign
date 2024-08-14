//
//  Pineapple.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 13/08/24.
//

import SwiftUI

struct Pineapple: View {
    @EnvironmentObject var coordinator: Coordinator
    @State var fruits: [String: Page] = ["🍉": .watermelon, "🍋": .lemon]

    var body: some View {
        VStack {
            List {
                ForEach(fruits.keys.sorted(), id: \.self) { key in
                    Button(action: {
                        // Navigate to the corresponding page based on the key
                        if let page = fruits[key] {
                            coordinator.push(page: page)
                        }
                    }) {
                        Text(key)
                    }
                }
            }
            Spacer()
        }

        .navigationTitle("🍍")
    }
}

#Preview {
    Pineapple()
}
