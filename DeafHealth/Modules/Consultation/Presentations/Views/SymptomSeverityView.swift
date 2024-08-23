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

    @State var sliderValue: Double = DecimalConstants.d1
    @State var sliderValue2: Double = DecimalConstants.d2

    @State var status: String = "Rendah"
    @State var description: String = "Hampir tidak terasa"

    @State var warna: Color = .init(red: DecimalConstants.d8 * 0.125, green: DecimalConstants.d16 * 0.03, blue: DecimalConstants.d2 * 0.005)

    var body: some View {
        VStack(spacing: DecimalConstants.zeros) {
            ZStack {
                HStack {
                    Spacer()

                    HStack {
                        Text("3").bold().font(Font.system(size: 14)).bold() + Text(" / 6 pertanyaan").font(Font.custom("SF Pro", size: 13))
                    }
                    .foregroundColor(.gray)
                }
                .padding(.horizontal, DecimalConstants.d8 * 2.75)
            }
            .padding(.top, DecimalConstants.d8 * 2)
            .padding(.bottom, DecimalConstants.d8 * 2)

            Spacer().frame(height: DecimalConstants.d8 * 4)

            HStack {
                Text("\(AppLabel.severityStatement) ").font(Font.system(size: 20))

                    + Text("\(selectedSeverity)").font(Font.system(size: 20)).bold().foregroundColor(.darkBlue)

                    + Text(" dari 10.").font(Font.custom("SF Pro", size: 20))
            }
            .padding(.bottom, DecimalConstants.d8 * 1.25)
            .multilineTextAlignment(.center)
            .frame(maxWidth: 257, alignment: .center)

            Spacer().frame(height: DecimalConstants.d8 * 2.25)

            Text("\(status)").font(
                Font.system(size: 20)
                    .weight(.bold)
            )
            .foregroundColor(warna)

            Spacer().frame(height: DecimalConstants.d8 * 1.5)

            Text("\(description)")
                .font(Font.system(size: 14))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .frame(width: 290, height: 68, alignment: .top)

            Spacer().frame(height: DecimalConstants.d8 * 2.5)

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
            .padding(.horizontal, DecimalConstants.d8 * 6.75)
            .onChange(of: sliderValue) {
                isAnswerProvided = true

                selectedSeverity = sliderValue.formatted()

                let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
                feedbackGenerator.impactOccurred()

                complaintViewModel.updateAnswer(for: 3, with: selectedSeverity)

                switch sliderValue {
                case DecimalConstants.d1:
                    status = "Rendah"
                    warna = Color(red: 0.07, green: 0.61, blue: 0.48)
                    description = "Hampir tidak terasa"
                case DecimalConstants.d2:
                    status = "Rendah"
                    warna = Color(red: 0.4, green: 0.62, blue: 0.33)
                    description = "Tidak nyaman"
                case DecimalConstants.d4 - DecimalConstants.d1:
                    status = "Rendah"
                    warna = Color(red: 0.54, green: 0.62, blue: 0.26)
                    description = "Bisa ditoleransi"
                case DecimalConstants.d4:
                    status = "Sedang"
                    warna = Color(red: 0.67, green: 0.63, blue: 0.2)
                    description = "Menyedihkan"
                case DecimalConstants.d4 + DecimalConstants.d1:
                    status = "Sedang"
                    warna = Color(red: 0.82, green: 0.63, blue: 0.13)
                    description = "Sangat Menyedihkan"
                case DecimalConstants.d8 - DecimalConstants.d2:
                    status = "Sedang"
                    warna = Color(red: 0.84, green: 0.57, blue: 0.17)
                    description = "Intens sehingga menyebabkan tidak fokus dan komunikasi terganggu"
                case DecimalConstants.d8 - DecimalConstants.d1:
                    status = "Parah"
                    warna = Color(red: 0.85, green: 0.52, blue: 0.21)
                    description = "Sangat intens dan mendominasi indera sehingga tidak bisa berkomunikasi dengan baik dan tidak mampu melakukan perawatan sendiri"
                case DecimalConstants.d8:
                    status = "Parah"
                    warna = Color(red: 0.86, green: 0.47, blue: 0.25)
                    description = "Sangat mengerikan sehingga tidak dapat berpikir jernih dan mengubah kepribadian ketika sakit"
                case DecimalConstants.d8 + DecimalConstants.d1:
                    status = "Parah"
                    warna = Color(red: 0.87, green: 0.42, blue: 0.29)
                    description = "Menyiksa tak tertahankan sehingga tidak bisa ditoleransi dan ingin segera dihilangkan"
                case DecimalConstants.d8 + DecimalConstants.d2:
                    status = "Parah"
                    warna = Color(red: 0.89, green: 0.35, blue: 0.35)
                    description = "Tidak terbayangkan dan tidak dapat diungkapkan karena sampai tidak sadarkan diri"
                default:
                    break
                }
            }

            Spacer().frame(height: DecimalConstants.d8 * 23.5)

            ZStack {
                VStack {
                    HStack(alignment: .top, spacing: DecimalConstants.d1) {
                        HStack(alignment: .center, spacing: DecimalConstants.d2 * 0.25) {
                            VStack {
                                Text("0-3").bold()
                                Text("Rendah")
                            }
                            .padding(.horizontal, DecimalConstants.d8 * 2.75)

                            Text("Lemah dan tidak terlalu mengganggu")
                        }
                        .padding(.horizontal)
                        .padding(.vertical, DecimalConstants.d4 * 0.625)
                    }
                    .frame(width: 330, alignment: .topLeading)
                    .background(Color(red: 0.96, green: 1, blue: 0.96))
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color(red: 0.6, green: 0.6, blue: 0.6), lineWidth: DecimalConstants.zeros)
                    )

                    HStack(alignment: .top, spacing: DecimalConstants.d1) {
                        HStack(alignment: .center, spacing: DecimalConstants.d2 * 0.25) {
                            VStack {
                                Text("4-6").bold()
                                Text("Sedang")
                            }
                            .padding(.horizontal, DecimalConstants.d8 * 2.75)
                            Text("Cukup terasa dan mulai mengganggu aktivitas, tetapi masih bisa ditoleransi.")
                        }
                        .padding(.horizontal)
                        .padding(.vertical, DecimalConstants.d4 * 0.625)
                    }
                    .frame(width: 330, alignment: .topLeading)
                    .background(Color(red: 1, green: 1, blue: 0.93))
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color(red: 0.6, green: 0.6, blue: 0.6), lineWidth: DecimalConstants.zeros)
                    )

                    HStack(alignment: .top, spacing: DecimalConstants.zeros) {
                        HStack(alignment: .center, spacing: DecimalConstants.d2 * 0.25) {
                            VStack {
                                Text("7-10").bold()
                                Text("Parah")
                            }
                            .padding(.horizontal, DecimalConstants.d8 * 2.75)

                            Text("Sangat kuat dan sering kali tak tertahankan.")
                        }
                        .padding(.horizontal)
                        .padding(.vertical, DecimalConstants.d4 * 0.625)
                    }
                    .frame(width: 330, alignment: .topLeading)
                    .background(Color(red: 1, green: 0.96, blue: 0.96))
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color(red: 0.6, green: 0.6, blue: 0.6), lineWidth: DecimalConstants.zeros)
                    )
                }
            }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .font(
                    Font.custom("SF Pro", size: 12)
                        .weight(.bold)
                ).padding(.vertical, DecimalConstants.d8 * 1.5)
                .foregroundColor(Color(red: 0.58, green: 0.58, blue: 0.58))
                .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                .cornerRadius(25)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .inset(by: DecimalConstants.zeros)
                        .stroke(Color(red: 0.6, green: 0.6, blue: 0.6), lineWidth: DecimalConstants.zeros)
                )

            Spacer().frame(height: DecimalConstants.d8 * 2.25)

            Button {
                coordinator.present(sheet: .symptomWorseningFactors)
            } label: {
                Text(AppLabel.continueButton).frame(width: 363, height: 52)
                    .background(isAnswerProvided ? Color(red: 0.25, green: 0.48, blue: 0.68) : Color.gray)
                    .cornerRadius(25)
                    .foregroundColor(Color("FFFFFF"))
                    .disabled(!isAnswerProvided)
                    .padding(.bottom, DecimalConstants.d16 * 2)
            }
        }
        .onAppear {
            selectedSeverity = complaintViewModel.currentComplaint.answers[3]
        }
        .background {
            Image(ImageLabel.sheetBackground)
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
