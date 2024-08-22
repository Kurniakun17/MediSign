//
//  CameraView.swift
//  DeafHealth
//
//  Created by Stefan Agusto Hutapea on 21/08/24.
//

import AVFoundation
import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    var cameraModel: CameraModel

    func makeUIViewController(context: Context) -> CameraViewController {
        let viewController = CameraViewController()
        viewController.cameraModel = cameraModel
        return viewController
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
        // No update logic needed for now
    }
}

class CameraViewController: UIViewController {
    var cameraModel: CameraModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let cameraModel = cameraModel else { return }

        let previewLayer = AVCaptureVideoPreviewLayer(session: cameraModel.captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)

        cameraModel.captureSession.startRunning()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cameraModel?.stopCamera()
    }
}
