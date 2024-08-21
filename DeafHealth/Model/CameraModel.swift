//
//  CameraModel.swift
//  DeafHealth
//
//  Created by Stefan Agusto Hutapea on 21/08/24.
//

import AVFoundation
import Vision
import CoreML
import SwiftUI

class CameraModel: NSObject, ObservableObject {
    @Published var recognizedAction: String = "Waiting for Action..."
    @Published var showRecognizedAction: Bool = false
    @Published var recognizedActionSentence: String = ""
    var captureSession: AVCaptureSession!
    
    private var frameBuffer: MLMultiArray?
    private let bufferSize = 60
    private let model = try! SignLanguageClassifier()
    private var currentFrameIndex = 0
    
    var onActionRecognized: ((String) -> Void)?  // Callback for recognized actions
    
    override init() {
        super.init()
        captureSession = AVCaptureSession()
    }

    // Setup the camera
    func setupCamera() {
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
            fatalError("No front camera available")
        }
        
        do {
            // Remove any existing inputs before adding a new one
            captureSession.inputs.forEach { input in
                captureSession.removeInput(input)
            }
            
            let input = try AVCaptureDeviceInput(device: camera)
            captureSession.addInput(input)
        } catch {
            print("Error: \(error)")
            return
        }
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(videoOutput)
        
        initializeFrameBuffer()
    }

    func stopCamera() {
        captureSession.stopRunning()
    }

    // Initialize the MLMultiArray for buffering the frames
    func initializeFrameBuffer() {
        self.frameBuffer = try? MLMultiArray(shape: [60, 3, 21], dataType: .float32)
        self.currentFrameIndex = 0
    }

    // Update the MLMultiArray with the extracted keypoints for the current frame
    func updateFrameBuffer(with keypoints: [[Float]], at frameIndex: Int) {
        guard let frameBuffer = frameBuffer else { return }
        
        for jointIndex in 0..<keypoints.count {
            let keypoint = keypoints[jointIndex]
            for coordinateIndex in 0..<3 {
                let index = [NSNumber(value: frameIndex), NSNumber(value: coordinateIndex), NSNumber(value: jointIndex)]
                frameBuffer[index] = NSNumber(value: keypoint[coordinateIndex])
            }
        }
    }

    // Run the prediction using the filled frame buffer
    func predictAction() {
        guard let frameBuffer = frameBuffer else { return }
        
        do {
            let prediction = try model.prediction(poses: frameBuffer)
            
            // Log the detailed probabilities
            print("Predicted label: \(prediction.label) with probabilities: \(prediction.labelProbabilities)")

            // Check if the highest probability exceeds 80% confidence
            if let maxProbability = prediction.labelProbabilities[prediction.label], maxProbability > 0.8 {
                DispatchQueue.main.async {
                    // Notify the ViewModel of the recognized action
                    self.onActionRecognized?(prediction.label)
                    
                    // Update recognized action sentence
                    if !self.recognizedActionSentence.isEmpty {
                        self.recognizedActionSentence += " "
                    }
                    self.recognizedActionSentence += prediction.label
                    self.showRecognizedAction = true
                }
            }
        } catch {
            print("Error running prediction: \(error)")
        }
        
        initializeFrameBuffer()
    }
}

extension CameraModel: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        HandPoseDetector().extractHandPoses(from: sampleBuffer) { [weak self] keypoints in
            guard let self = self else { return }
            
            // Update the MLMultiArray with the keypoints for the current frame
            self.updateFrameBuffer(with: keypoints, at: self.currentFrameIndex)
            
            // Move to the next frame index
            self.currentFrameIndex += 1
            
            // If we've collected enough frames (60), run prediction
            if self.currentFrameIndex == self.bufferSize {
                self.predictAction()
            }
        }
    }
}
