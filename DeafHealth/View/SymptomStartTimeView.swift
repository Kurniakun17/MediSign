//
//  SymptomStartTimeView.swift
//  DeafHealth
//
//  Created by Anthony on 16/08/24.
//

import SwiftUI

struct SymptomStartTimeView: View {
    @EnvironmentObject var coordinator: Coordinator
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var complaintViewModel: ComplaintViewModel

    @State private var selectedStartTime: String = ""
    @State private var isAnswerProvided: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                SegmentedProgressBar(totalSteps: 8, currentStep: 3)
                    .padding(.horizontal)

                HStack {
                    Button(action: {
                        coordinator.popToRoot()
                        coordinator.push(page: .consultationMenuView)
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
                Text("Kapan gejala ini mulai terasa?")
                    .font(.title3)
                    .multilineTextAlignment(.center)
            }
            Spacer()

            // Example start time selection
            Button(action: {
                selectedStartTime = "1 Hari yang Lalu"
                isAnswerProvided = true
                complaintViewModel.updateAnswer(for: 2, with: selectedStartTime)
            }) {
                Text("1 Hari yang Lalu")
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

                Text(complaintViewModel.getSummary(for: 2))
                    .font(.subheadline)
                    .padding(.bottom, 8)
                    .padding(.leading, 32)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 16) {
                    Button("Kembali") {
                        coordinator.pop() // Navigate back to ConsultationMenuView
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("green"))
                    .cornerRadius(25)
                    .foregroundColor(Color("FFFFFF"))

                    Button("Lanjutkan") {
                        coordinator.push(page: .symptomSeverity)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isAnswerProvided ? Color("light-green-button") : Color.gray)
                    .cornerRadius(25)
                    .foregroundColor(Color("FFFFFF"))
                    .disabled(!isAnswerProvided)  // Disable the button if no answer is provided
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
    SymptomStartTimeView()
        .environmentObject(Coordinator())
        .environmentObject(ComplaintViewModel(datasource: LocalDataSource.shared))
}
