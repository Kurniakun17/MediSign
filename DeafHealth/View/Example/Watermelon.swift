//
//  Watermelon.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 13/08/24.
//
import SwiftUI

struct Watermelon: View {
    @EnvironmentObject var coordinator: Coordinator
    var body: some View {
        VStack {
            List {
                Button(action: {
                    coordinator.push(page: .lemon)
                }) {
                    Text("🍋")
                }
            }
            .navigationTitle("🍉")
        }
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
    Watermelon()
}
