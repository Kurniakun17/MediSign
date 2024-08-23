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
        VStack(spacing: DecimalConstants.zeros) {
            ZStack {
                HStack {
                    Spacer()

                    HStack {
                        Text("6").bold().font(Font.system(size: 14)).bold() + Text(" / 6 pertanyaan").font(Font.custom("SF Pro", size: 13))
                    }
                    .foregroundColor(.gray)
                }
                .padding(.horizontal, DecimalConstants.d8 * 2.75)
            }
            .padding(.top, DecimalConstants.d8 * 2)
            .padding(.bottom, DecimalConstants.d8 * 2)

            Spacer().frame(height: DecimalConstants.d8 * 4)

            if hasNotConsultedBefore {
                HStack {
                    Text("Belum pernah konsultasi ke dokter.").font(Font.custom("SF Pro", size: 20))
                }
                .padding(.bottom, DecimalConstants.d8)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 257, alignment: .center)
            } else {
                HStack {
                    Text("\(AppLabel.previousConsultation) ").font(Font.custom("SF Pro", size: 20))

                        + Text("\(complaintViewModel.currentComplaint.answers[6].lowercased() == "" ? "_____" : complaintViewModel.currentComplaint.answers[6].lowercased())").font(Font.system(size: 20)).bold().foregroundColor(.darkBlue)

                        + Text(".").font(Font.custom("SF Pro", size: 20))
                }
                .padding(.bottom, DecimalConstants.d8)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 257, alignment: .center)
            }

            if !hasNotConsultedBefore {
                TextField("Tambahkan obat yang diberikan dokter sebelumnya", text: $previousMed)
                    .padding(DecimalConstants.d8 * 2.125)
                    .padding(.vertical, -DecimalConstants.d8 * 0.625)
                    .font(.custom("SF Pro", size: 14))
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .onChange(of: previousMed) { newValue in
                        isAnswerProvided = !newValue.isEmpty
                        complaintViewModel.updateAnswer(for: 6, with: previousMed)
                    }
                    .padding(.horizontal)
                    .padding(.top, DecimalConstants.d8 * 8)
            }

            Spacer()

            VStack(spacing: DecimalConstants.d8 * 2) {
                Button(action: {
                    hasNotConsultedBefore.toggle()
                    if hasNotConsultedBefore {
                        previousMed = "Tidak ada riwayat konsultasi sebelumnya"
                        isAnswerProvided = true
                        complaintViewModel.updateAnswer(for: 6, with: previousMed)
                    } else {
                        previousMed = ""
                        isAnswerProvided = false
                        complaintViewModel.updateAnswer(for: 6, with: previousMed)
                    }
                }) {
                    HStack {
                        Rectangle()
                            .foregroundColor(hasNotConsultedBefore ? .blue : .clear)
                            .frame(width: DecimalConstants.d8 * 1.875, height: DecimalConstants.d8 * 1.875)
                            .cornerRadius(3)
                            .overlay(
                                RoundedRectangle(cornerRadius: 3)
                                    .inset(by: DecimalConstants.d8 * 0.0625)
                                    .stroke(.black, lineWidth: DecimalConstants.d8 * 0.125)
                            )

                        Text("Saya belum pernah konsultasi ke dokter")
                            .font(.custom("SF Pro", size: 14))
                            .foregroundColor(Color.black)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, DecimalConstants.d8)

//                Button(AppLabel.continueButton) {
//                    coordinator.push(page: .summary)
//                    dismiss()
//                }
//                .frame(width: 363, height: 52)
//                .background(isAnswerProvided ? Color(red: 0.25, green: 0.48, blue: 0.68) : Color.gray)
//                .cornerRadius(25)
//                .foregroundColor(Color("FFFFFF"))
//                .disabled(!isAnswerProvided)

                Button {
                    coordinator.push(page: .summary)
                    dismiss()
                } label: {
                    Text(AppLabel.continueButton).frame(width: 363, height: 52)
                        .background(isAnswerProvided ? Color(red: 0.25, green: 0.48, blue: 0.68) : Color.gray)
                        .cornerRadius(25)
                        .foregroundColor(Color("FFFFFF"))
                        .disabled(!isAnswerProvided)
                        .padding(.bottom, DecimalConstants.d16 * 2)
                }
            }
            .padding(.bottom, DecimalConstants.d8 * 5)
        }
        .background {
            Image(ImageLabel.sheetBackground)
        }
        .onAppear {
            previousMed = complaintViewModel.currentComplaint.answers[6]
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
