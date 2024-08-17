//
//  ComplaintFlowView.swift
//  DeafHealth
//
//  Created by Anthony on 17/08/24.
//

import SwiftUI

struct ComplaintFlowView: View {
    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .mainComplaint)
                .navigationDestination(for: Page.self) { page in
                    coordinator.build(page: page)
                }
        }
    }
}

#Preview {
    ComplaintFlowView()
        .environmentObject(Coordinator())
}
