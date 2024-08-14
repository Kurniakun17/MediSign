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
        NavigationStack(path: $coordinator.path
        ) {
            coordinator.build(page: .strawberry)
                .navigationDestination(for: Page.self) {
                    page in
                    coordinator.build(page: page)
                }
        }
        .environmentObject(coordinator)
        .environmentObject(complaintViewModel)
    }
}

#Preview {
    ContentView()
}
