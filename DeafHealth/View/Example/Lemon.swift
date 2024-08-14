//
//  Lemon.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 13/08/24.
//

import Foundation
import SwiftUI

struct Lemon: View {
    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        VStack {
            List {
                Button(action: {
                    coordinator.push(page: .banana)
                }) {
                    Text("🍌")
                }
            }
            Spacer()
        }
        .navigationTitle("🍋")
    }
}

#Preview {
    Lemon()
}
