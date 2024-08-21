//
//  MessageViewModelTests.swift
//  DeafHealthTests
//
//  Created by Kurnia Kharisma Agung Samiadjie on 20/08/24.
//

@testable import DeafHealth
import XCTest

final class MessageViewModelTests: XCTestCase {
    var viewModel: MessageViewModel!

    override func setUpWithError() throws {
        viewModel = MessageViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testAddMessages() throws {
//        GIVEN
        let newMessage = Message(role: .user, body: "Hai namaku kurnia")

//        WHEN
        viewModel.addMessage(newMessage: newMessage)

//        ASSERT
        XCTAssertEqual(viewModel.messages.count, 2)
        XCTAssertEqual(viewModel.messages.last?.body, "Hai namaku kurnia")
        XCTAssertEqual(viewModel.messages.last?.role, .user)
    }
}
