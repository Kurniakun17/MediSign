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

    @State private var previousMed: String = ""
    @State private var isAnswerProvided: Bool = false
    @State private var hasNotConsultedBefore: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Spacer()

                    HStack {
                        Text("6").bold().font(Font.custom("SF Pro Bold", size: 14)) + Text(" / 6 pertanyaan").font(Font.custom("SF Pro", size: 13))
                    }
                    .foregroundColor(.gray)
                }
                .padding(.horizontal, 22)
            }
            .padding(.top, 16)
            .padding(.bottom, 16)

            VStack(spacing: 8) {
                Text("Saya pernah konsultasi ke dokter dan diberikan obat yaitu ____.")
                    .font(.title3)
                    .multilineTextAlignment(.center)

                TextField("Tambahkan obat yang diberikan dokter sebelumnya", text: $previousMed)
                    .padding(17)
                    .padding(.vertical, -5)
                    .font(.custom("SF Pro", size: 14))
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .onChange(of: previousMed) { newValue in
                        isAnswerProvided = !newValue.isEmpty
                        complaintViewModel.updateAnswer(for: 7, with: previousMed)
                    }
                    .padding(.horizontal)
                    .padding(.top, 64)
            }
            .padding(.bottom, 16)

            Spacer()

            VStack(spacing: 16) {
                Button(action: {
                    hasNotConsultedBefore.toggle()
                    if hasNotConsultedBefore {
                        previousMed = "Tidak ada konsultasi sebelumnya"
                        isAnswerProvided = true
                        complaintViewModel.updateAnswer(for: 7, with: previousMed)
                    } else {
                        previousMed = ""
                        isAnswerProvided = false
                        complaintViewModel.updateAnswer(for: 7, with: previousMed)
                    }
                }) {
                    HStack {
                        Image(systemName: hasNotConsultedBefore ? "checkmark.square" : "square")
                            .foregroundColor(hasNotConsultedBefore ? Color.blue : Color.gray)
                        Text("Saya Belum pernah konsultasi ke dokter")
                            .font(.custom("SF Pro", size: 14))
                            .foregroundColor(Color.black)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
                
                Button(action: {
                    coordinator.push(page: .summary)
                }) {
                    Text("Lanjutkan")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isAnswerProvided ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .disabled(!isAnswerProvided)
            }
            .padding(.bottom, 40)
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
