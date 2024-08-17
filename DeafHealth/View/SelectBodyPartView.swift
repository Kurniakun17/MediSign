//
//  SelectBodyPartView.swift
//  DeafHealth
//
//  Created by Anthony on 16/08/24.
//

import SwiftUI

struct SelectBodyPartView: View {
    @EnvironmentObject var coordinator: Coordinator
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                // Progress bar centered in the view
                SegmentedProgressBar(totalSteps: 8, currentStep: 2)
                    .padding(.horizontal)  // Ensure there's some padding around it

                HStack {
                    // Custom back button
                    Button(action: {
                        coordinator.pop()  // Handle back navigation
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("black"))  // Replace with your color
                    }
                    .padding(.leading, 25)

                    Spacer()  // This spacer helps to align the progress bar centrally
                }
            }
            .padding(.top, 16)
            .padding(.bottom, 16)

            VStack(spacing: 0) {
                Text("Pilih bagian tubuh yang")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                Text("terasa nyeri")
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

                Text("Halo Dokter. Saya merasakan nyeri di _____.")
                    .font(.subheadline)
                    .padding(.bottom, 8)
                    .padding(.leading, 32)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 16) {
                    Button("Kembali") {
                        coordinator.pop()  // Go back to the previous view in the flow
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("green"))
                    .cornerRadius(25)
                    .frame(width: (UIScreen.main.bounds.width - 64) * 0.353)
                    .foregroundColor(Color("FFFFFF"))

                    Button("Lanjutkan") {
                        coordinator.push(page: .symptomStartTime)
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
        .navigationBarBackButtonHidden(true)  // Hide the default back button
    }
}

#Preview {
    SelectBodyPartView()
}
