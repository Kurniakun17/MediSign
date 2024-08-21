//
//  RecordingSheet.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 20/08/24.
//

import Foundation
import SwiftUI

struct RecordingSheet: View {
    @EnvironmentObject var messageViewModel: MessageViewModel
    @EnvironmentObject var speechViewModel: SpeechViewModel
    let stopRecording: () -> Void

    var body: some View {
        return GeometryReader { geometry in
            VStack {
                Text("Dokter berbicara")
                    .fontWeight(.bold)
                    .font(.title2)

                Text(speechViewModel.transcript)
                    .foregroundStyle(.gray)

                Spacer()

                HStack(spacing: 2) {
                    ForEach(speechViewModel.audioLevels, id: \.self.id) { audioLevel in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.primaryBlue)
                            .frame(width: 4, height: max(geometry.size.height * audioLevel.level * 0.5, 1))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 200, alignment: .center)

                Button(action: {
                    stopRecording()
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
            .padding(36)
        }
        .presentationDetents([.height(500)])
    }
}
