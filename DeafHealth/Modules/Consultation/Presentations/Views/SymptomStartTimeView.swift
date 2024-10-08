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

    @State private var selectedUnit: String = "_____"
    @State private var isAnswerProvided: Bool = false

    @State private var selectedNumber: String = "_"

    @State var batasAtas: Int = 24

    var body: some View {
        VStack(spacing: DecimalConstants.zeros) {
            ZStack {
                HStack {
                    Spacer()

                    HStack {
                        Text("2").bold().font(Font.system(size: 14)).bold() + Text(" / 6 pertanyaan").font(Font.custom("SF Pro", size: 13))
                    }
                    .foregroundColor(.gray)
                }
                .padding(.horizontal, DecimalConstants.d8 * 2.75)
            }
            .padding(.top, DecimalConstants.d8 * 2)
            .padding(.bottom, DecimalConstants.d8 * 2)

            Spacer().frame(height: DecimalConstants.d16 * 3)

            HStack {
                Text("Saya merasakan gejala ini sejak ").font(Font.system(size: 20))

                    + Text("\(selectedNumber + " " + selectedUnit.lowercased())").font(Font.system(size: 20)).bold().foregroundColor(.darkBlue)

                    + Text(" yang lalu.").font(Font.custom("SF Pro", size: 20))
            }
            .padding(.bottom, DecimalConstants.d8)
            .multilineTextAlignment(.center)
            .frame(maxWidth: 257, alignment: .center)

            HStack {
                Picker("Waktu", selection: $selectedNumber) {
                    ForEach(1 ..< batasAtas, id: \.self) { time in
                        Text("\(time)").tag("\(time)")
                    }
                }
                .pickerStyle(.wheel)
                .frame(minWidth: 60)
                .onChange(of: selectedNumber) {
                    complaintViewModel.updateAnswer(for: 2, with: selectedNumber + " " + selectedUnit.lowercased())
                    let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
                    feedbackGenerator.impactOccurred()

                    if selectedNumber != "_" && selectedUnit != "_____" {
                        isAnswerProvided = true
                    }
                }

                Picker("Unit", selection: $selectedUnit) {
                    Text("Jam").tag("Jam")
                    Text("Hari").tag("Hari")
                    Text("Minggu").tag("Minggu")
                    Text("Bulan").tag("Bulan")
                    Text("Tahun").tag("Tahun")

                }.pickerStyle(.wheel).frame(minWidth: 120)
                    .onChange(of: selectedUnit) {
                        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
                        feedbackGenerator.impactOccurred()

                        if selectedUnit == "Jam" {
                            batasAtas = 24
                        } else if selectedUnit == "Hari" {
                            batasAtas = 7
                        } else if selectedUnit == "Minggu" {
                            batasAtas = 4
                        } else if selectedUnit == "Bulan" {
                            batasAtas = 12
                        } else if selectedUnit == "Tahun" {
                            batasAtas = 10
                        }

                        if selectedNumber != "_" && selectedUnit != "_____" {
                            isAnswerProvided = true
                        }

                        complaintViewModel.updateAnswer(for: 2, with: selectedNumber + " " + selectedUnit.lowercased())
                    }
            }.padding(.horizontal, DecimalConstants.d16 * 6.875)

            Spacer().frame(height: DecimalConstants.d8 * 43.75)

            Button {
                coordinator.present(sheet: .symptomSeverity)
            } label: {
                Text(AppLabel.continueButton).frame(width: 363, height: 52)
                    .background(isAnswerProvided ? Color(red: 0.25, green: 0.48, blue: 0.68) : Color.gray)
                    .cornerRadius(25)
                    .foregroundColor(Color("FFFFFF"))
                    .disabled(!isAnswerProvided)
                    .padding(.bottom, DecimalConstants.d16 * 2)
            }

//            Button(AppLabel.continueButton) {
//                coordinator.present(sheet: .symptomSeverity)
//            }
//            .frame(width: 363, height: 52)
//            .background(isAnswerProvided ? Color(red: 0.25, green: 0.48, blue: 0.68) : Color.gray)
//            .cornerRadius(25)
//            .foregroundColor(Color("FFFFFF"))
//            .disabled(!isAnswerProvided)
        }
        .onAppear {
            selectedNumber = String(complaintViewModel.currentComplaint.answers[2].split(separator: " ")[0])
            
            if complaintViewModel.currentComplaint.answers[2].contains(" ") {
                selectedUnit = String(complaintViewModel.currentComplaint.answers[2].split(separator: " ")[1])

            }
        }

        .background {
            Image(ImageLabel.sheetBackground)
        }
    }
}

#Preview {
    SymptomStartTimeView()
        .environmentObject(Coordinator())
        .environmentObject(ComplaintViewModel(datasource: LocalDataSource.shared))
}
