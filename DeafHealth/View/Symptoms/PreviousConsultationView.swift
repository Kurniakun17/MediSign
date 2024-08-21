//
//  PreviousConsultationView.swift
//  DeafHealth
//
//  Created by Anthony on 16/08/24.
//

import SwiftUI

struct PreviousConsultationView: View {
    @FocusState private var isFocused: Bool

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
                        Text("6").bold().font(Font.system(size: 14)).bold() + Text(" / 6 pertanyaan").font(Font.custom("SF Pro", size: 13))
                    }
                    .foregroundColor(.gray)
                }
                .padding(.horizontal, 22)
            }
            .padding(.top, 16)
            .padding(.bottom, 16)

            Spacer().frame(height: 32)

            if hasNotConsultedBefore {
                HStack {
                    Text("Belum pernah konsultasi ke dokter.").font(Font.system(size: 20))
                }
                .padding(.bottom, 8)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 257, alignment: .center)
            } else {
                HStack {
                    Text("Saya pernah konsultasi ke dokter dan diberikan obat yaitu ").font(Font.system(size: 20))

                        +
                        Text("\(previousMed.lowercased() == "" ? "_____" : previousMed.lowercased())").font(Font.system(size: 20)).bold().foregroundColor(.darkBlue)

                        + Text(".").font(Font.custom("SF Pro", size: 20))
                }
                .padding(.bottom, 8)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 257, alignment: .center)
            }

            if !hasNotConsultedBefore {
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
                        Rectangle()
                            .foregroundColor(hasNotConsultedBefore ? .blue : .clear)
                            .frame(width: 15, height: 15)
                            .cornerRadius(3)
                            .overlay(
                                RoundedRectangle(cornerRadius: 3)
                                    .inset(by: 0.5)
                                    .stroke(.black, lineWidth: 1)
                            )

                        Text("Saya belum pernah konsultasi ke dokter")
                            .font(.custom("SF Pro", size: 14))
                            .foregroundColor(Color.black)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 8)

                Button("Selesai") {
                    //            coordinator.push(page: .symptomWorseningFactors)
                    coordinator.push(page: .summary)
                    dismiss()
                }
                .frame(width: 363, height: 52)
                .background(isAnswerProvided ? Color(red: 0.25, green: 0.48, blue: 0.68) : Color.gray)
                .cornerRadius(25)
                .foregroundColor(Color("FFFFFF"))
                .disabled(!isAnswerProvided)
            }
            .padding(.bottom, 40)
        }
        .background {
            Image("sheet-background")
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
