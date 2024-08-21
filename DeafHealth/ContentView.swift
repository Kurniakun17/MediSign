//
//  ContentView.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 13/08/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var complaintViewModel = ComplaintViewModel(datasource: .shared)
    @StateObject private var coordinator = Coordinator()

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            VStack {
                // Your main menu content
                Button("Tambah Keluhan") {
                    coordinator.push(page: .consultationMenuView)
                }
                .padding()
            }
            .navigationDestination(for: Page.self) { page in
                coordinator.build(page: page)
            }
            .sheet(item: $coordinator.sheet) { sheet in
                coordinator.build(sheet: sheet)
            }
            .fullScreenCover(item: $coordinator.fullScreenCover) { fullScreenCover in
                coordinator.build(fullScreenCover: fullScreenCover)
            }
        }
        .environmentObject(coordinator)
        .environmentObject(complaintViewModel)
    }
}

#Preview {
    ContentView()
}
