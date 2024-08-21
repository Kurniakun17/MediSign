
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
        // GIVEN
        viewModel.startTranscribe()

        // WHEN
        viewModel.stopTranscribing()

        // ASSERT
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
