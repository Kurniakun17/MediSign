//
//  SymptomSeverityView.swift
//  DeafHealth
//
//  Created by Anthony on 16/08/24.
//

import SwiftUI

struct SymptomSeverityView: View {
    @EnvironmentObject var coordinator: Coordinator
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var complaintViewModel: ComplaintViewModel

    @State private var selectedSeverity: String = "__"
    @State private var isAnswerProvided: Bool = false

    @State var sliderValue: Double = 1.0
    @State var sliderValue2: Double = 2.0

    @State var status: String = "Rendah"
    @State var description: String = "Hampir tidak terasa"

    @State var warna: Color = .init(red: 0, green: 0.53, blue: 0.01)

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Spacer()

                    HStack {
                        Text("3").bold().font(Font.custom("SF Pro Bold", size: 14)) + Text(" / 6 pertanyaan").font(Font.custom("SF Pro", size: 13))
                    }
                    .foregroundColor(.gray)
                }
                .padding(.horizontal, 22)
            }
            .padding(.top, 16)
            .padding(.bottom, 16)

            Spacer().frame(height: 32)

            HStack {
                Text("Rasa sakitnya ").font(Font.custom("SF Pro", size: 20))

                    + Text("\(selectedSeverity)").bold().underline().foregroundColor(.darkGreen)

                    + Text(" dari 10.").font(Font.custom("SF Pro", size: 20))
            }
            .padding(.bottom, 8)
            .multilineTextAlignment(.center)
            .frame(maxWidth: 257, alignment: .center)

            Spacer().frame(height: 18)

            Text("\(status)").font(
                Font.custom("SF Pro", size: 20)
                    .weight(.bold)
            )
            .foregroundColor(warna)

            Spacer().frame(height: 12)

            Text("\(description)")
                .font(Font.custom("SF Pro", size: 14))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .frame(width: 290, height: 68, alignment: .top)

            Spacer().frame(height: 20)

            CustomSlider(
                value: $sliderValue,
                range: 1 ... 10,
                step: 1,
                label: {
                    Text("")
                },
                minimumValueLabel: {
                    Text("1")
                        .font(.body.smallCaps()).bold()
                },
                maximumValueLabel: {
                    Text("10")
                        .font(.body).bold()
                },
                progressColor: warna
            )
            .accentColor(.blue)
            .padding(.horizontal, 54)
            .onChange(of: sliderValue) {
                isAnswerProvided = true
                selectedSeverity = sliderValue.formatted()
                
                complaintViewModel.updateAnswer(for: 2, with: selectedSeverity)

                
                if sliderValue == 0 {
                    status = ""
                    description = "Tidak ada rasa sakit"

                } else if sliderValue == 1 {
                    status = "Rendah"
                    warna = Color(red: 0.07, green: 0.61, blue: 0.48)
                    description = "Hampir tidak terasa"

                } else if sliderValue == 2 {
                    status = "Rendah"
                    warna = Color(red: 0.4, green: 0.62, blue: 0.33)
                    description = "Tidak nyaman"

                } else if sliderValue == 3 {
                    status = "Rendah"
                    warna = Color(red: 0.54, green: 0.62, blue: 0.26)
                    description = "Bisa ditoleransi"

                } else if sliderValue == 4 {
                    status = "Sedang"
                    warna = Color(red: 0.67, green: 0.63, blue: 0.2)
                    description = "Menyedihkan"

                } else if sliderValue == 5 {
                    status = "Sedang"
                    warna = Color(red: 0.82, green: 0.63, blue: 0.13)
                    description = "Sangat Menyedihkan"

                } else if sliderValue == 6 {
                    status = "Sedang"
                    warna = Color(red: 0.84, green: 0.57, blue: 0.17)
                    description = "Intens sehingga menyebabkan tidak fokus dan komunikasi terganggu"

                } else if sliderValue == 7 {
                    status = "Parah"
                    warna = Color(red: 0.85, green: 0.52, blue: 0.21)
                    description = "Sangat intens dan mendominasi indera sehingga tidak bisa berkomunikasi dengan baik dan tidak mampu melakukan perawatan sendiri"

                } else if sliderValue == 8 {
                    status = "Parah"
                    warna = Color(red: 0.86, green: 0.47, blue: 0.25)
                    description = "Sangat mengerikan sehingga tidak dapat berpikir jernih dan mengubah kepribadian ketika sakit"

                } else if sliderValue == 9 {
                    status = "Parah"
                    warna = Color(red: 0.87, green: 0.42, blue: 0.29)
                    description = "Menyiksa tak tertahankan sehingga tidak bisa ditoleransi dan ingin segera dihilangkan"

                } else if sliderValue == 10 {
                    status = "Parah"
                    warna = Color(red: 0.89, green: 0.35, blue: 0.35)
                    description = "Tidak terbayangkan dan tidak dapat diungkapkan karena sampai tidak sadarkan diri"
                }
            }

            Spacer().frame(height: 188)

            ZStack {
                VStack {
                    HStack(alignment: .top, spacing: 8) {
                        HStack(alignment: .center, spacing: 4) {
                            VStack {
                                Text("0-3").bold()
                                Text("Rendah")
                            }
                            .padding(.horizontal, 22)

                            Text("Lemah dan tidak terlalu mengganggu")
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    }
                    .frame(width: 330, alignment: .topLeading)
                    .background(Color(red: 0.96, green: 1, blue: 0.96))
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color(red: 0.6, green: 0.6, blue: 0.6), lineWidth: 0)
                    )

                    HStack(alignment: .top, spacing: 8) {
                        HStack(alignment: .center, spacing: 4) {
                            VStack {
                                Text("4-6").bold()
                                Text("Sedang")
                            }
                            .padding(.horizontal, 22)
                            Text("Cukup terasa dan mulai mengganggu aktivitas, tetapi masih bisa ditoleransi.")
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)                    }
                    .frame(width: 330, alignment: .topLeading)
                    .background(Color(red: 1, green: 1, blue: 0.93))
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color(red: 0.6, green: 0.6, blue: 0.6), lineWidth: 0)
                    )

                    HStack(alignment: .top, spacing: 0) {
                        HStack(alignment: .center, spacing: 4) {
                            VStack {
                                Text("7-10").bold()
                                Text("Parah")
                            }
                            .padding(.horizontal, 22)

                            Text("Sangat kuat dan sering kali tak tertahankan.")
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)                    }
                    .frame(width: 330, alignment: .topLeading)
                    .background(Color(red: 1, green: 0.96, blue: 0.96))
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color(red: 0.6, green: 0.6, blue: 0.6), lineWidth: 0)
                    )
                }
            }.frame(width: 363)
                .font(
                Font.custom("SF Pro", size: 12)
                .weight(.bold)
                )                .padding(.vertical, 12)
                .foregroundColor(Color(red: 0.58, green: 0.58, blue: 0.58))
                .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                .cornerRadius(25)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .inset(by: 0)
                        .stroke(Color(red: 0.6, green: 0.6, blue: 0.6), lineWidth: 0)
                )

            Spacer().frame(height: 18)

            Button("Lanjutkan") {
//                coordinator.push(page: .symptomWorseningFactors)
                coordinator.present(sheet: .symptomWorseningFactors)

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
    SymptomSeverityView()
        .environmentObject(Coordinator())
        .environmentObject(ComplaintViewModel(datasource: LocalDataSource.shared))
}
