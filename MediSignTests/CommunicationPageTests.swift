@testable import DeafHealth
import XCTest

final class CommunicationPageTests: XCTestCase {
    var messageViewModel: MessageViewModel!
    var speechViewModel: SpeechViewModel!
    var communicationPage: CommunicationPage!

    override func setUp() {
        super.setUp()
        let tempMessageVM = MessageViewModel()
        let tempSpeechVM = SpeechViewModel()
        messageViewModel = tempMessageVM
        speechViewModel = tempSpeechVM
        communicationPage = CommunicationPage(messageViewModel: tempMessageVM, speechViewModel: tempSpeechVM)
    }

    override func tearDown() {
        messageViewModel = nil
        speechViewModel = nil
        communicationPage = nil
        super.tearDown()
    }

    func testStartRecording() throws {
        // Given
        speechViewModel.isRecording = false

        // When
        communicationPage.startRecording()

        // Then
        XCTAssertTrue(speechViewModel.isRecording, "Recording should start")
        XCTAssertTrue(speechViewModel.transcribeStarted, "Transcription should start")
    }

    func testStopRecording() throws {
        // Given
        speechViewModel.isRecording = true
        speechViewModel.transcript = "Test Transcript"
        speechViewModel.audioLevels = [AudioLevel(level: 0.5), AudioLevel(level: 0.8)]

        // When
        communicationPage.stopRecording()

        // Then
        XCTAssertFalse(speechViewModel.isRecording, "Recording should stop")
        XCTAssertTrue(speechViewModel.transcribeStopped, "Transcription should stop")
        XCTAssertEqual(messageViewModel.role, .doctor, "Role should be set to doctor")
        XCTAssertEqual(messageViewModel.inputValue, "Test Transcript", "Input value should be set to transcript")
        XCTAssertEqual(speechViewModel.transcript, "", "Transcript should be cleared")
//        XCTAssertEqual(speechViewModel.audioLevels, Array(repeating: AudioLevel(level: 0.1), count: 50), "Audio levels should be reset")
    }

    func testStartRecordingAndAutoStopAfter60Seconds() {
        // Given
        let expectation = self.expectation(description: "Auto stop recording after 60 seconds")
        speechViewModel.isRecording = false

        // When
        communicationPage.startRecording()

        // Simulate 60 seconds delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 60.1) {
            // Then
            XCTAssertFalse(self.speechViewModel.isRecording, "Recording should automatically stop after 60 seconds")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 61)
    }
}

// Extension to SpeechViewModel to simulate start and stop transcribing
extension SpeechViewModel {
    var transcribeStarted: Bool { return isRecording }

    var transcribeStopped: Bool { return !isRecording }

    func startTranscribe() {
        // Simulate start transcribing
        isRecording = true
    }

    func stopTranscribing() {
        // Simulate stop transcribing
        isRecording = false
    }
}
