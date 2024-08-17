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

    @State private var isPresentingComplaintFlow = false

    var body: some View {
        VStack {
            // Existing content of your homepage

            Button("Tambah Keluhan") {
                isPresentingComplaintFlow.toggle()
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $isPresentingComplaintFlow, onDismiss: {
                // Perform any cleanup or state reset here
                coordinator.popToRoot()
            }) {
                ComplaintFlowView()
                    .environmentObject(coordinator)
                    .environmentObject(complaintViewModel)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

#Preview {
    ContentView()
}
