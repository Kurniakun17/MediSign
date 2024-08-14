//
//  Pineapple.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 13/08/24.
//

import SwiftUI

struct Pineapple: View {
    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        VStack {
            List {
                Button(action: {
                    print("hai")
                    coordinator.present(sheet: .testSheet)
                }) {
                    Text("Show sheet")
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
