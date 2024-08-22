
//
//  HandPoseDetector.swift
//  DeafHealth
//
//  Created by Stefan Agusto Hutapea on 21/08/24.
//

import Vision
import AVFoundation

class HandPoseDetector {
    
    // Extract hand poses from a sample buffer
    func extractHandPoses(from sampleBuffer: CMSampleBuffer, completion: @escaping ([[Float]]) -> Void) {
        let handPoseRequest = VNDetectHumanHandPoseRequest()
        let handler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer, orientation: .up, options: [:])
        
        do {
            try handler.perform([handPoseRequest])
            if let observations = handPoseRequest.results {
                // Process observations and extract keypoints
                let keypoints = processHandPoseObservations(observations)
                completion(keypoints)
            }
        } catch {
            print("Error detecting hand poses: \(error)")
            completion([]) // Return empty if there's an error
        }
    }
    
    // Process hand pose observations and convert them into keypoints
    private func processHandPoseObservations(_ observations: [VNHumanHandPoseObservation]) -> [[Float]] {
        guard let observation = observations.first else { return [] }
        
        do {
            let recognizedPoints = try observation.recognizedPoints(.all)
            // Convert CGFloat values to Float explicitly
            let keypoints: [[Float]] = recognizedPoints.values.map { point in
                return [Float(point.location.x), Float(point.location.y), Float(point.confidence)]  // [x, y, confidence]
            }
            return keypoints
        } catch {
            print("Error processing hand pose observation: \(error)")
            return []
        }
    }
}

