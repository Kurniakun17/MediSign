//
//  SignLanguageInterpreterViewModel.swift
//  DeafHealth
//
//  Created by Stefan Agusto Hutapea on 21/08/24.
//

import AVFoundation
import CoreML
import SwiftUI
import Vision

class SignLanguageInterpreterViewModel: ObservableObject {
    @Published var recognizedText: String = ""
    @Published var isInterpreting: Bool = false
    var cameraModel: CameraModel?

    private var detectedWords: Set<String> = []

    init() {
        self.cameraModel = CameraModel()
        cameraModel?.onActionRecognized = { [weak self] recognizedAction in
            DispatchQueue.main.async {
                self?.processRecognizedAction(recognizedAction)
            }
        }
    }

    func startInterpreting() {
        isInterpreting = true
        cameraModel?.setupCamera()
    }

    func stopInterpreting() {
        isInterpreting = false
        cameraModel?.stopCamera()
        detectedWords.removeAll()
        recognizedText = ""
    }

    private func processRecognizedAction(_ action: String) {
        guard action != "Nothing" else { return } // Ignore "Nothing" class

        if !detectedWords.contains(action) {
            recognizedText += recognizedText.isEmpty ? action : " \(action)"
            detectedWords.insert(action)
        }
    }

    private func appendToRecognizedText(_ word: String) {
        recognizedText = recognizedText.isEmpty ? word : "\(recognizedText) \(word)"
    }
}
