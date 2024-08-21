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
    @State private var isFrontView: Bool = true // Track front or back view

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Spacer()

                    HStack {
                        Text("1").bold().font(Font.custom("SF Pro Bold", size: 14)) + Text(" / 6 pertanyaan").font(Font.custom("SF Pro", size: 13))
                    }
                    .foregroundColor(.gray)
                }
                .padding(.horizontal, 22)
                .padding(.top, 24)
            }

            VStack(spacing: 8) {
                Text("Halo, Dokter. Saya merasakan \(complaintViewModel.answers[0]) di bagian \(selectedBodyPart.isEmpty ? "____" : selectedBodyPart).")
                    .font(.title3)
                    .foregroundColor(selectedBodyPart.isEmpty ? .primary : Color.blue)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            .padding(.top, 16)

            Spacer()

            ZStack {
                if isFrontView {
                    Image("front")  // Using the front view image from assets
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .overlay(frontBodyCircles())
                } else {
                    Image("back")  // Using the back view image from assets
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .overlay(backBodyCircles())
                }

                // Left arrow for flipping to back view
                Button(action: {
                    withAnimation {
                        isFrontView = false
                    }
                }) {
                    Image("left-arrow")  // Using the left arrow image from assets
                }
                .position(x: 30, y: UIScreen.main.bounds.height / 2)
                .opacity(isFrontView ? 1 : 0) // Hide when on the back view

                // Right arrow for flipping to front view
                Button(action: {
                    withAnimation {
                        isFrontView = true
                    }
                }) {
                    Image("right-arrow")  // Using the right arrow image from assets
                }
                .position(x: UIScreen.main.bounds.width - 30, y: UIScreen.main.bounds.height / 2)
                .opacity(isFrontView ? 0 : 1) // Hide when on the front view
            }
            .padding()

            Spacer()

            Button("Lanjutkan") {
                coordinator.present(sheet: .symptomStartTime) // Proceed to Question 2
            }
            .frame(width: 363, height: 52)
            .background(isAnswerProvided ? Color(red: 0.25, green: 0.48, blue: 0.68) : Color.gray)
            .cornerRadius(25)
            .foregroundColor(Color("FFFFFF"))
            .disabled(!isAnswerProvided)
            .padding(.bottom, 32)
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)
    }

    // Circles for front body view
    func frontBodyCircles() -> some View {
        ZStack {
            Circle().positionedCircle(x: 150, y: 200, bodyPart: "Leher", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 120, y: 230, bodyPart: "Bahu", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 140, y: 260, bodyPart: "Dada", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 140, y: 290, bodyPart: "Perut", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 100, y: 320, bodyPart: "Lengan Atas", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 120, y: 360, bodyPart: "Siku tangan", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 160, y: 390, bodyPart: "Pergelangan Tangan", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 140, y: 420, bodyPart: "Kelamin", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 140, y: 450, bodyPart: "Paha atas", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 160, y: 480, bodyPart: "Lutut", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 140, y: 510, bodyPart: "Jari dan telapak kaki", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
        }
    }

    func backBodyCircles() -> some View {
        ZStack {
            Circle().positionedCircle(x: 150, y: 200, bodyPart: "Tengkuk", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 120, y: 230, bodyPart: "Pundak", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 140, y: 260, bodyPart: "Punggung Atas", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 140, y: 290, bodyPart: "Punggung Bawah", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 140, y: 320, bodyPart: "Pinggul", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 120, y: 360, bodyPart: "Jari dan Telapak tangan", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 140, y: 390, bodyPart: "Pantat/Bokong", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
//            Circle().positionedCircle(x: 140, y: 450, bodyPart: "Belakang Paha", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 160, y: 480, bodyPart: "Betis", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
            Circle().positionedCircle(x: 140, y: 510, bodyPart: "Pergelangan Kaki", selectedBodyPart: $selectedBodyPart, isAnswerProvided: $isAnswerProvided)
        }
    }
}


