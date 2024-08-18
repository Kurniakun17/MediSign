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
    @EnvironmentObject var complaintViewModel: ComplaintViewModel

    @State private var selectedDoctorConsultation: String = ""
    @State private var isAnswerProvided: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                SegmentedProgressBar(totalSteps: 8, currentStep: 8)
                    .padding(.horizontal)

                HStack {
                    Button(action: {
                        coordinator.pop()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("black"))
                    }
                    .padding(.leading)

                    Spacer()
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

            // Example doctor consultation selection
            Button(action: {
                selectedDoctorConsultation = "Ya"
                isAnswerProvided = true
                complaintViewModel.updateAnswer(for: 7, with: selectedDoctorConsultation)
            }) {
                Text("Ya")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
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

                Text(complaintViewModel.getSummary(for: 7))
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
                    .foregroundColor(Color("FFFFFF"))

                    Button("Lanjutkan") {
                        coordinator.push(page: .summary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isAnswerProvided ? Color("light-green-button") : Color.gray)
                    .cornerRadius(25)
                    .foregroundColor(Color("FFFFFF"))
                    .disabled(!isAnswerProvided)
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
        .environmentObject(Coordinator())
        .environmentObject(ComplaintViewModel(datasource: LocalDataSource.shared))
}
