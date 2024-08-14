//
//  Banana.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 13/08/24.
//

import SwiftUI

struct Banana: View {
    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        VStack {
            List {
                Button(action: {
                    coordinator.push(page: .watermelon)
                }) {
                    Text("🍉")
                }
            }
            Spacer()
        }
        .navigationTitle("🍌")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button(action: {
                    coordinator.popToRoot()
                }) {
                    Text("Back to root")
                }
            })
        }
    }
}

#Preview {
    Banana()
}
