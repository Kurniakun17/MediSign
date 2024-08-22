//
//  ContentView.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 13/08/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var coordinator = Coordinator()
    @StateObject var complaintViewModel = ComplaintViewModel(datasource: .shared)
    @StateObject var userDataViewModel = UserDataViewModel(datasource: .shared)

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            Group {
                if userDataViewModel.currentUser != nil {
                    coordinator.build(page: .homepage)
                } else {
                    coordinator.build(page: .onboardingWelcome)
                }
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
        .environmentObject(userDataViewModel)
    }
}

#Preview {
    ContentView()
}
