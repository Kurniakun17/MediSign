//
//  SignLanguageInterpreterViewModel.swift
//  DeafHealth
//
//  Created by Stefan Agusto Hutapea on 21/08/24.
//

import SwiftUI
import AVFoundation
import Vision
import CoreML

class SignLanguageInterpreterViewModel: ObservableObject {
    @Published var recognizedText: String = ""
    @Published var isInterpreting: Bool = false

    var cameraModel: CameraModel?

    init() {
        self.cameraModel = CameraModel()
        self.cameraModel?.onActionRecognized = { [weak self] recognizedAction in
            DispatchQueue.main.async {
                self?.recognizedText += " \(recognizedAction)"
            }
        }
    }

    func startInterpreting() {
        self.isInterpreting = true
        cameraModel?.setupCamera()
    }

    func stopInterpreting() {
        self.isInterpreting = false
        cameraModel?.stopCamera()
    }
}
