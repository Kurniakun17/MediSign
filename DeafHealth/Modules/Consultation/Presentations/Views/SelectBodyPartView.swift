//
//  SelectBodyPartView.swift
//  DeafHealth
//
//  Created by Anthony on 16/08/24.
//

import SwiftUI

struct SelectBodyPartView: View {
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var complaintViewModel: ComplaintViewModel

    @State private var selectedBodyPart: String = ""
    @State private var isAnswerProvided: Bool = false
    @State private var isFrontView: Bool = true
    @State private var showSideSelection: Bool = false
    @State private var tappedBodyPart: String = ""
    @State private var menuPosition: CGPoint = .zero

    var body: some View {
        VStack(spacing: DecimalConstants.zeros) {
            ZStack {
                HStack {
                    Spacer()

                    HStack {
                        Text("1").bold().font(Font.custom("SF Pro Bold", size: 14)) + Text(" / 6 pertanyaan").font(Font.custom("SF Pro", size: 13))
                    }
                    .foregroundColor(.gray)
                }
                .padding(.horizontal, DecimalConstants.d8 * 2.75)
                .padding(.top, DecimalConstants.d16 * 1.5)
            }

            HStack(spacing: DecimalConstants.d8) {
                Text("\(AppLabel.complaintStatement)") + Text(" \(complaintViewModel.currentComplaint.answers[0].lowercased())").bold().foregroundColor(AppColors.blueMedium) + Text(" di bagian ") + Text("\(complaintViewModel.currentComplaint.answers[1].isEmpty ? "____" : complaintViewModel.currentComplaint.answers[1].lowercased()).")
                    .foregroundColor(AppColors.blueMedium).bold()
            }
            .padding(.horizontal)
            .padding(.top, DecimalConstants.d8 * 2)
            .multilineTextAlignment(.center)
            .font(Font.system(size: 20))

            Spacer()

            ZStack {
                if isFrontView {
                    Image(ImageLabel.frontViewBody)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .overlay(frontBodyCircles())
                } else {
                    Image(ImageLabel.backViewBody)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .overlay(backBodyCircles())
                }

                // Left arrow for flipping the view
                Button(action: {
                    withAnimation {
                        isFrontView.toggle()
                    }
                }) {
                    Image(ImageLabel.leftArrow)
                }
                .position(x: UIScreen.main.bounds.width * 0.1, y: UIScreen.main.bounds.height * 0.3)

                // Right arrow for flipping the view
                Button(action: {
                    withAnimation {
                        isFrontView.toggle()
                    }
                }) {
                    Image(ImageLabel.rightArrow)
                }
                .position(x: UIScreen.main.bounds.width * 0.8, y: UIScreen.main.bounds.height * 0.3)

//                if showSideSelection {
//                    compactMenu
//                        .position(menuPosition)
//                        .animation(.easeInOut, value: showSideSelection)
//                }
            }
            .padding()
            Spacer()

            Button {
                coordinator.present(sheet: .symptomStartTime)
            } label: {
                Text(AppLabel.continueButton).frame(width: 363, height: 52)
                    .background(isAnswerProvided ? Color(red: 0.25, green: 0.48, blue: 0.68) : Color.gray)
                    .cornerRadius(25)
                    .foregroundColor(Color("FFFFFF"))
                    .disabled(!isAnswerProvided)
                    .padding(.bottom, DecimalConstants.d16 * 2)
            }

//            Button(AppLabel.continueButton) {
//                coordinator.present(sheet: .symptomStartTime)
//            }
//            .frame(width: 363, height: 52)
//            .background(isAnswerProvided ? Color(red: 0.25, green: 0.48, blue: 0.68) : Color.gray)
//            .cornerRadius(25)
//            .foregroundColor(Color("FFFFFF"))
//            .disabled(!isAnswerProvided)
//            .padding(.bottom, DecimalConstants.d16 * 2)
        }
        .background {
            Image(ImageLabel.sheetBackground)
        }
        .onChange(of: selectedBodyPart) {
            complaintViewModel.updateAnswer(for: 1, with: selectedBodyPart)
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)
    }

    // Circles for front body view
    func frontBodyCircles() -> some View {
        ZStack {
            Circle().positionedCircle(x: 86, y: 95, bodyPart: "Leher", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 22, y: 115, bodyPart: "Bahu", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 113, y: 149, bodyPart: "Dada", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 88, y: 210, bodyPart: "Perut", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 170, y: 163, bodyPart: "Lengan Atas", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 14, y: 205, bodyPart: "Siku Tangan", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 175, y: 255, bodyPart: "Pergelangan Tangan", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 88, y: 274, bodyPart: "Kelamin", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 57, y: 335, bodyPart: "Paha Atas", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 120, y: 415, bodyPart: "Lutut", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 56, y: 537, bodyPart: "Jari dan Telapak Kaki", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
        }
    }

    func backBodyCircles() -> some View {
        ZStack {
            Circle().positionedCircle(x: 96, y: 86, bodyPart: "Tengkuk", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 45, y: 110, bodyPart: "Pundak", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 125, y: 145, bodyPart: "Punggung Atas", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 70, y: 172, bodyPart: "Punggung Bawah", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 54, y: 245, bodyPart: "Pinggul", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 15, y: 302, bodyPart: "Jari dan Telapak Tangan", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 120, y: 280, bodyPart: "Pantat", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 65, y: 350, bodyPart: "Belakang Paha", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 115, y: 455, bodyPart: "Betis", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 60, y: 540, bodyPart: "Pergelangan Kaki", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
        }
    }
}

#Preview {
    SelectBodyPartView()
        .environmentObject(Coordinator())
        .environmentObject(ComplaintViewModel(datasource: LocalDataSource.shared))
}
