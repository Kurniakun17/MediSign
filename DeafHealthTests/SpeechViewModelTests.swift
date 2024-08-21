//
//  SpeechViewModelTests.swift
//  DeafHealthTests
//
//  Created by Kurnia Kharisma Agung Samiadjie on 20/08/24.
//

@testable import DeafHealth
import XCTest

final class SpeechViewModelTests: XCTestCase {
    var viewModel: SpeechViewModel!

    override func setUpWithError() throws {
        viewModel = SpeechViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testStopTranscribing() throws {
        // Start transcribing
        viewModel.startTranscribe()

        // Stop transcribing
        viewModel.stopTranscribing()

        // Ensure that the transcription stops and the engine resets
        XCTAssertNil(viewModel.audioEngine)
        XCTAssertNil(viewModel.request)
        XCTAssertNil(viewModel.task)
        XCTAssertFalse(viewModel.isRecording)
    }

    func testSpeakErrorUpdatesTranscript() throws {
        // Simulate an error
        let error = SpeechViewModel.RecognizerError.nilRecognizer
        viewModel.speakError(error)

        // Ensure the transcript is updated with the error message
        print(error.message)
        XCTAssertEqual(viewModel.transcript, "<< \(error.message) >>")
    }
}
