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

    @State var viewModel: SymptomStartTimeViewModel = .init()

    @State var isLainnyaSelected = false

    @State var selectedTime: String = "_____"
    @State var selectedDate: Date = .init()

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                // Progress bar centered in the view
                SegmentedProgressBar(totalSteps: 8, currentStep: 3)
                    .padding(.horizontal)

                HStack {
                    // Custom back button
                    Button(action: {
                        coordinator.pop() // Handle back navigation
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("black")) // Replace with your color
                    }
                    .padding(.leading)

                    Spacer() // This spacer helps to align the progress bar centrally
                }
            }
            .padding(.top, 16)
            .padding(.bottom, 16)

            VStack(spacing: 0) {
                Text("Kapan gejala mulai terasa?")
                    .font(.title3)
                    .multilineTextAlignment(.center)
            }

            ForEach(viewModel.options) { option in
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
                        viewModel.selectedOption(optionId: option.id)
                        selectedTime = option.title.lowercased()
                        isLainnyaSelected = false
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
                    viewModel.selectedOption()
                    isLainnyaSelected = true
                }

                if isLainnyaSelected {
                    DatePicker("", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .onChange(of: selectedDate) { newDate in
                            selectedTime = DateFormatter.localizedString(from: newDate, dateStyle: .medium, timeStyle: .none)
                        }
                }
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

                HStack {
                    Text("Halo Dokter. Saya merasakan gejala ini sejak ")
                        + Text("\(selectedTime)").bold()
                        + Text(".")
                }
                .font(.subheadline)
                .padding(.bottom, 8)
                .padding(.leading, 32)
                .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 16) {
                    Button("Kembali") {
                        coordinator.pop()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("green"))
                    .cornerRadius(25)
                    .frame(width: (UIScreen.main.bounds.width - 64) * 0.353)
                    .foregroundColor(Color("FFFFFF"))

                    Button("Lanjutkan") {
                        coordinator.push(page: .symptomSeverity)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("light-green-button"))
                    .cornerRadius(25)
                    .frame(width: (UIScreen.main.bounds.width - 64) * 0.647)
                    .foregroundColor(Color("FFFFFF"))
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
    SymptomStartTimeView()
}
