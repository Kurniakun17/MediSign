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
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Spacer()

                    HStack {
                        Text("2").bold().font(Font.custom("SF Pro Bold", size: 14)) + Text(" / 6 pertanyaan").font(Font.custom("SF Pro", size: 13))
                    }
                    .foregroundColor(.gray)
                }
                .padding(.horizontal, 22)
            }
            .padding(.top, 16)
            .padding(.bottom, 16)

            Spacer().frame(height: 147)

            HStack {
                Text("Saya merasakan gejala ini sejak ").font(Font.custom("SF Pro", size: 20))

                    + Text("\(selectedNumber + " " + selectedUnit.lowercased())").bold().underline().foregroundColor(.darkGreen)

                    + Text(" yang lalu.").font(Font.custom("SF Pro", size: 20))
            }
            .padding(.bottom, 8)
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
                    isAnswerProvided = true
                    complaintViewModel.updateAnswer(for: 1, with: selectedNumber + " " + selectedUnit.lowercased())
                }

                Picker("Unit", selection: $selectedUnit) {
                    Text("Jam").tag("Jam")
                    Text("Hari").tag("Hari")
                    Text("Minggu").tag("Minggu")
                    Text("Bulan").tag("Bulan")
                    Text("Tahun").tag("Tahun")

                }.pickerStyle(.wheel).frame(minWidth: 120)
                    .onChange(of: selectedUnit) {
                        isAnswerProvided = true

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

                        complaintViewModel.updateAnswer(for: 1, with: selectedNumber + " " + selectedUnit.lowercased())
                    }
            }.padding(.horizontal, 110)

            Spacer().frame(height: 250)

            Button("Lanjutkan") {
//                coordinator.push(page: .symptomSeverity)
                coordinator.present(sheet: .symptomSeverity)
            }
            .frame(width: 363, height: 52)
            .background(isAnswerProvided ? Color(red: 0.25, green: 0.48, blue: 0.68) : Color.gray)
            .cornerRadius(25)
            .foregroundColor(Color("FFFFFF"))
            .disabled(!isAnswerProvided)
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
