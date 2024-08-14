//
//  Strawberry.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 13/08/24.
//

import Foundation
import SwiftUI

struct Strawberry: View {
    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Button(action: {
                        coordinator.push(page: .lemon)
                    }) {
                        Text("🍋")
                    }

                    Button(action: {
                        coordinator.push(page: .pineapple)
                    }) {
                        Text("🍍")
                    }
                }
                Spacer()
            }
            .navigationTitle("🍓")
        }
    }
}

#Preview {
    Strawberry()
}
