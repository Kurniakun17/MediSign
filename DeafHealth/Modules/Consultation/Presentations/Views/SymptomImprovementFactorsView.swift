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
        VStack(spacing: DecimalConstants.zeros) {
            ZStack {
                HStack {
                    Spacer()

                    HStack {
                        Text("5").bold().font(Font.system(size: 14)).bold() + Text(" / 6 pertanyaan").font(Font.custom("SF Pro", size: 13))
                    }
                    .foregroundColor(.gray)
                }
                .padding(.horizontal, DecimalConstants.d8 * 2.75)
            }
            .padding(.top, DecimalConstants.d8 * 2)
            .padding(.bottom, DecimalConstants.d8 * 2)

            Spacer().frame(height: DecimalConstants.d8 * 4)

            if isNotAvailable {
                HStack {
                    Text("Tidak terdapat faktor yang membuat gejala membaik.").font(Font.custom("SF Pro", size: 20))
                }
                .padding(.bottom, DecimalConstants.d8)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 257, alignment: .center)
            } else {
                HStack {
                    Text("\(AppLabel.improvementFactors) ").font(Font.custom("SF Pro", size: 20))

                        + Text("\(selectedFactor.lowercased() == "" ? "_____" : selectedFactor.lowercased())").font(Font.system(size: 20)).bold().foregroundColor(.darkBlue)

                        + Text(".").font(Font.custom("SF Pro", size: 20))
                }
                .padding(.bottom, DecimalConstants.d8)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 257, alignment: .center)
            }

            Spacer().frame(height: DecimalConstants.d8 * 6.75)

            if !isNotAvailable {
                ZStack(alignment: .leading) {
                    TextEditor(text: $factor)
                        .padding(EdgeInsets(top: DecimalConstants.d8 * 1.25, leading: DecimalConstants.d8 * 1.25, bottom: DecimalConstants.d8 * 1.25, trailing: DecimalConstants.d8 * 1.25))
                        .frame(width: 360, height: 180)
                        .background(Color.white)
                        .cornerRadius(25)
                        .focused($isFocused)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.gray, lineWidth: DecimalConstants.d1)
                        )
                        .onChange(of: factor) { newValue in
                            selectedFactor = newValue
                            complaintViewModel.updateAnswer(for: 5, with: selectedFactor)
                            isAnswerProvided = true
                        }

                    if factor.isEmpty && !isFocused {
                        Text("Tambahkan faktor yang membuat gejala membaik")
                            .foregroundColor(.gray)
                            .padding(.horizontal, DecimalConstants.d8 * 2)
                            .padding(.vertical, DecimalConstants.d8 * 1.5)
                            .offset(x: DecimalConstants.d8 * 0.625, y: -DecimalConstants.d8 * 7.75)
                            .font(Font.custom("SF Pro Bold", size: 14))
                            .multilineTextAlignment(.leading)
                    }
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
                        Text("Mengonsumsi makanan/minuman tertentu (sebutkan)")
                    }
                    HStack(alignment: .top) {
                        Text("   •")
                        Text("Mengonsumsi obat tertentu (sebutkan)")
                    }
                }
            }
            .font(Font.system(size: 14)).italic()
            .padding(.horizontal, DecimalConstants.d8 * 2.25)
            .padding(.vertical, DecimalConstants.d8 * 1.75)
            .frame(width: 360, alignment: .topLeading)
            .background(Color(red: 0.97, green: 0.97, blue: 0.97))
            .cornerRadius(25)
            .foregroundColor(.gray)

            Spacer().frame(height: DecimalConstants.d8 * 2.25)

            HStack {
                Button {
                    isAnswerProvided = true
                    isNotAvailable.toggle()

                    if !isNotAvailable {
                        isAnswerProvided = false
                    }
                } label: {
                    if isNotAvailable {
                        Rectangle()
                            .foregroundColor(.blue)
                            .frame(width: DecimalConstants.d8 * 1.875, height: DecimalConstants.d8 * 1.875)
                            .cornerRadius(3)
                            .overlay(
                                RoundedRectangle(cornerRadius: 3)
                                    .inset(by: DecimalConstants.d8 * 0.0625)
                                    .stroke(.black, lineWidth: DecimalConstants.d8 * 0.125)
                            )
                    } else {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: DecimalConstants.d8 * 1.875, height: DecimalConstants.d8 * 1.875)
                            .cornerRadius(3)
                            .overlay(
                                RoundedRectangle(cornerRadius: 3)
                                    .inset(by: DecimalConstants.d8 * 0.0625)
                                    .stroke(.black, lineWidth: DecimalConstants.d8 * 0.125)
                            )
                    }
                }.onChange(of: isNotAvailable) {
                    factor = ""
                    selectedFactor = ""
                }

                Text("Tidak ada faktor yang membuat gejala membaik").font(Font.custom("SF Pro Bold", size: 14))
            }

            Spacer().frame(height: DecimalConstants.d8 * 2.25)

            Button {
                coordinator.present(sheet: .previousConsultation)
            } label: {
                Text(AppLabel.continueButton).frame(width: 363, height: 52)
                    .background(isAnswerProvided ? Color(red: 0.25, green: 0.48, blue: 0.68) : Color.gray)
                    .cornerRadius(25)
                    .foregroundColor(Color("FFFFFF"))
                    .disabled(!isAnswerProvided)
                    .padding(.bottom, DecimalConstants.d16 * 2)
            }

//            Button(AppLabel.continueButton) {
//                coordinator.present(sheet: .previousConsultation)
//            }
//            .frame(width: 363, height: 52)
//            .background(isAnswerProvided ? Color(red: 0.25, green: 0.48, blue: 0.68) : Color.gray)
//            .cornerRadius(25)
//            .foregroundColor(Color("FFFFFF"))
//            .disabled(!isAnswerProvided)
        }
        .onAppear() {
            selectedFactor = complaintViewModel.answers[5]
        }
        .background {
            Image(ImageLabel.sheetBackground)
        }
    }
}

#Preview {
    SymptomImprovementFactorsView()
        .environmentObject(Coordinator())
        .environmentObject(ComplaintViewModel(datasource: LocalDataSource.shared))
}
