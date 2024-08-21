//
//  SymptomImprovementFactorsView.swift
//  DeafHealth
//
//  Created by Anthony on 16/08/24.
//

import SwiftUI

struct SymptomImprovementFactorsView: View {
    @FocusState private var isFocused: Bool

    @EnvironmentObject var coordinator: Coordinator
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var complaintViewModel: ComplaintViewModel

    @State private var selectedFactor: String = "_____"
    @State private var factor: String = ""
    @State private var isAnswerProvided: Bool = false

    @State private var isNotAvailable = false

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Spacer()

                    HStack {
                        Text("5").bold().font(Font.custom("SF Pro Bold", size: 14)) + Text(" / 6 pertanyaan").font(Font.custom("SF Pro", size: 13))
                    }
                    .foregroundColor(.gray)
                }
                .padding(.horizontal, 22)
            }
            .padding(.top, 16)
            .padding(.bottom, 16)

            HStack {
                Text("Gejala semakin membaik ketika ").font(Font.custom("SF Pro", size: 20))

                    + Text("\(selectedFactor.lowercased())").bold().underline().foregroundColor(.darkGreen)

                    + Text(".").font(Font.custom("SF Pro", size: 20))
            }
            .padding(.bottom, 8)
            .multilineTextAlignment(.center)
            .frame(maxWidth: 257, alignment: .center)

            Spacer().frame(height: 54)

            ZStack(alignment: .leading) {
                TextEditor(text: $factor)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .frame(width: 360, height: 180)
                    .background(Color.white)
                    .cornerRadius(25)
                    .focused($isFocused) // Bind the focus state
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .onChange(of: factor) { newValue in
                        selectedFactor = newValue
                        complaintViewModel.updateAnswer(for: 3, with: selectedFactor)
                    }

                if factor.isEmpty && !isFocused {
                    Text("Tambahkan faktor yang membuat gejala membaik")
                        .foregroundColor(.gray)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .offset(x: 5, y: -62)
                        .font(Font.custom("SF Pro Bold", size: 14))
                        .multilineTextAlignment(.leading)
                }
            }

            Spacer()

            ZStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Contoh (dan tidak terbatas pada) : ")
                    HStack(alignment: .top) {
                        Text("   •")
                        Text("Istirahat")
                    }
                    HStack(alignment: .top) {
                        Text("   •")
                        Text("Mengonsumsi makanan atau minuman tertentu (sebutkan)")
                    }
                    HStack(alignment: .top) {
                        Text("   •")
                        Text("Mengonsumsi obat tertentu (sebutkan)")
                    }
                }
            }
            .font(Font.custom("SF Pro Bold", size: 14))
            .padding(.horizontal, 18)
            .padding(.vertical, 14)
            .frame(width: 360, alignment: .topLeading)
            .background(Color(red: 0.97, green: 0.97, blue: 0.97))
            .cornerRadius(25)
            .foregroundColor(.gray)

            Spacer().frame(height: 18)

            HStack {
                Button {
                    isAnswerProvided = true
                    isNotAvailable.toggle()
                } label: {
                    if isNotAvailable {
                        Rectangle()
                            .foregroundColor(.blue)
                            .frame(width: 15, height: 15)
                            .cornerRadius(3)
                            .overlay(
                                RoundedRectangle(cornerRadius: 3)
                                    .inset(by: 0.5)
                                    .stroke(.black, lineWidth: 1)
                            )
                    } else {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 15, height: 15)
                            .cornerRadius(3)
                            .overlay(
                                RoundedRectangle(cornerRadius: 3)
                                    .inset(by: 0.5)
                                    .stroke(.black, lineWidth: 1)
                            )
                    }
                }

                Text("Tidak ada faktor yang membuat gejala membaik").font(Font.custom("SF Pro Bold", size: 14))
            }

            Spacer().frame(height: 18)

            Button("Lanjutkan") {
                //            coordinator.push(page: .symptomWorseningFactors)
                coordinator.present(sheet: .symptomImprovementFactors)
            }
            .frame(width: 363, height: 52)
            .background(isAnswerProvided ? Color(red: 0.25, green: 0.48, blue: 0.68) : Color.gray)
            .cornerRadius(25)
            .foregroundColor(Color("FFFFFF"))
            .disabled(!isAnswerProvided)
        }
     
    }
}

#Preview {
    SymptomImprovementFactorsView()
        .environmentObject(Coordinator())
        .environmentObject(ComplaintViewModel(datasource: LocalDataSource.shared))
}
