//
//  SummaryView.swift
//  DeafHealth
//
//  Created by Anthony on 16/08/24.
//

import SwiftUI

struct SummaryView: View {
    @EnvironmentObject var coordinator: Coordinator
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {

            VStack(spacing: 0) {
                Text("Ringkasan Keluhan")
                    .font(.title3)
                    .multilineTextAlignment(.center)
            }
            Spacer()

            // Summary details here...
            VStack(spacing: 16) {

                HStack(spacing: 16) {
                    Button("Simpan") {
                        //simpan
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("green"))
                    .cornerRadius(25)
                    .frame(width: (UIScreen.main.bounds.width - 64))
                    .foregroundColor(Color("FFFFFF"))

                  
                }
                .padding(.horizontal, 32)
            }
            .padding(.top, 32)
            .padding(.bottom, 32)

        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SummaryView()
}
