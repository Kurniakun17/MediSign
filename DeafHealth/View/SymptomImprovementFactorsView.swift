//
//  SymptomImprovementFactorsView.swift
//  DeafHealth
//
//  Created by Anthony on 16/08/24.
//

import SwiftUI

struct SymptomImprovementFactorsView: View {
    @EnvironmentObject var coordinator: Coordinator
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var complaintViewModel: ComplaintViewModel

    @State private var selectedImprovement: String = ""
    @State private var isAnswerProvided: Bool = false

    @State var isLainnyaSelected = false

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                SegmentedProgressBar(totalSteps: 8, currentStep: 6)
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
                Text("Apa yang membuat gejala makin membaik?")
                    .font(.title3)
                    .multilineTextAlignment(.center)
            }

            ForEach(complaintViewModel.improvementOptions) { option in
                VStack {
                    ZStack {
                        Text(option.title).font(Font.custom("SF Pro", size: 16)
                            .weight(.medium))
                            .foregroundColor(option.isSelected ? .white : .black)
                    }
                    .padding(.horizontal, 17)
                    .padding(.vertical, 6)
                    .background(option.isSelected ? Color(red: 0.65, green: 0.76, blue: 0.64) : Color(red: 0.95, green: 0.95, blue: 0.95).opacity(0.95))
                    .cornerRadius(5)
                    .onTapGesture {
                        complaintViewModel.selectedOption(type: "improvement", optionId: option.id)
                        selectedImprovement = option.title.lowercased()
                        isLainnyaSelected = false
                        complaintViewModel.updateAnswer(for: 5, with: selectedImprovement)
                    }
                }.padding(.vertical, 3)
            }

            HStack {
                ZStack {
                    Text("+ Lainnya").font(Font.custom("SF Pro", size: 16)
                        .weight(.medium))
                        .foregroundColor(isLainnyaSelected ? .white : .black)
                }
                .padding(.horizontal, 17)
                .padding(.vertical, 6)
                .background(isLainnyaSelected ? Color(red: 0.65, green: 0.76, blue: 0.64) : Color(red: 0.95, green: 0.95, blue: 0.95).opacity(0.95))
                .cornerRadius(5)
                .onTapGesture {
                    complaintViewModel.selectedOption(type: "improvement")
                    isLainnyaSelected = true
                }

                if isLainnyaSelected {
                    TextField("Masukkan faktor yang memperparah", text: $selectedImprovement)
                        .padding()
                        .cornerRadius(8)
                        .onChange(of: selectedImprovement) { newValue in
                            isAnswerProvided = !newValue.isEmpty
                            complaintViewModel.updateAnswer(for: 5, with: selectedImprovement)
                        }
                }
            }
            Spacer()

            // Example improvement selection
            Button(action: {
                selectedImprovement = "Istirahat"
                isAnswerProvided = true
                complaintViewModel.updateAnswer(for: 5, with: selectedImprovement)
            }) {
                Text("Istirahat")
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

                Text(complaintViewModel.getSummary(for: 5))
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
                        coordinator.push(page: .additionalComplaints)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isAnswerProvided ? Color("light-green-button") : Color.gray)
                    .cornerRadius(25)
                    .foregroundColor(Color("FFFFFF"))
                    .disabled(!isAnswerProvided) // Disable the button if no answer is provided
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
    SymptomImprovementFactorsView()
        .environmentObject(Coordinator())
        .environmentObject(ComplaintViewModel(datasource: LocalDataSource.shared))
}
