//
//  PreviousConsultationView.swift
//  DeafHealth
//
//  Created by Anthony on 16/08/24.
//

import SwiftUI

struct PreviousConsultationView: View {
    @EnvironmentObject var coordinator: Coordinator
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                // Progress bar centered in the view
                SegmentedProgressBar(totalSteps: 8, currentStep: 8)
                    .padding(.horizontal)

                HStack {
                    // Custom back button
                    Button(action: {
                        coordinator.pop()  // Handle back navigation
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("black"))  // Replace with your color
                    }
                    .padding(.leading)

                    Spacer()  // This spacer helps to align the progress bar centrally
                }
            }
            .padding(.top, 16)
            .padding(.bottom, 16)

            VStack(spacing: 0) {
                Text("Apakah sudah pernah konsultasi ke dokter?")
                    .font(.title3)
                    .multilineTextAlignment(.center)
            }
            Spacer()

            // Green overlay at the bottom with buttons
            VStack(spacing: 16) {
                Text("Hasil Susun Keluhan")
                    .font(.headline)
                    .bold()
                    .padding(.top, 8)
                    .padding(.leading, 32)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("Tidak pernah konsultasi ke dokter.")
                    .font(.subheadline)
                    .padding(.bottom, 8)
                    .padding(.leading, 32)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 16) {
                    Button("Kembali") {
                        coordinator.pop()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("green"))
                    .cornerRadius(25)
                    .frame(width: (UIScreen.main.bounds.width - 64) * 0.353)
                    .foregroundColor(Color("FFFFFF"))

                    Button("Lanjutkan") {
                        coordinator.push(page: .summary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("light-green-button"))
                    .cornerRadius(25)
                    .frame(width: (UIScreen.main.bounds.width - 64) * 0.647)
                    .foregroundColor(Color("FFFFFF"))
                }
                .padding(.horizontal, 32)
            }
            .padding(.top, 32)
            .padding(.bottom, 32)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("light-green"))
                    .edgesIgnoringSafeArea(.bottom)
            )
            .cornerRadius(25, corners: [.topLeft, .topRight])
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    PreviousConsultationView()
}
