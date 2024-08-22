//
//  SignLanguageSheet.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 22/08/24.
//

import SwiftUI

struct SignLanguageSheet: View {
    @EnvironmentObject var signLanguageInterpreterViewModel: SignLanguageInterpreterViewModel
    @Binding var isShowingInterpreter: Bool

    var body: some View {
        return VStack {
            Text(AppLabel.signLanguageCameraTitle)
                .fontWeight(.bold)
                .font(.title2)
                .padding(.top, DecimalConstants.d16)

            VStack {
                // Camera View
                CameraView(cameraModel: signLanguageInterpreterViewModel.cameraModel!)
                    .frame(height: 500)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding()
            }
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding()
            .transition(.slide)

            Text(signLanguageInterpreterViewModel.recognizedText != "" ? signLanguageInterpreterViewModel.recognizedText : AppLabel.signLanguageCameraPlaceholder)
                .foregroundStyle(.gray)

            Button(action: {
                signLanguageInterpreterViewModel.stopInterpreting()
                isShowingInterpreter = false

            }) {
                HStack {
                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .fill(.primaryBlue)
                        .frame(width: 18, height: 18)
                }
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(RoundedRectangle(cornerRadius: 200).stroke(.gray, lineWidth: 2))
                .frame(width: 54, height: 54)
            }
        }
        .presentationDetents([.height(800)])
        .onDisappear {
            if signLanguageInterpreterViewModel.recognizedText != "" {
                signLanguageInterpreterViewModel.stopInterpreting()
            }
        }
    }
}
