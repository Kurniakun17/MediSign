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

    @State private var doesUserProfileExist: Bool = false

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            Group {
                if doesUserProfileExist {
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
        .onAppear {
            checkUserProfileExistence()
        }
    }

    private func checkUserProfileExistence() {
        if let userData = LocalDataSource.shared.fetchUserData(), !userData.name.isEmpty {
            doesUserProfileExist = true
        } else {
            doesUserProfileExist = false
        }
    }
}

#Preview {
    ContentView()
}
