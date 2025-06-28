//
//  Untitled.swift
//  EqualExpertTest
//
//  Created by Aklesh Rathaur on 28/06/25.
//

import XCTest
import Combine
@testable import EqualExpertTest // Replace with your module name if needed

final class ChatViewModelTests: XCTestCase {

    class MockSendService: SendMessageServiceProvider {
        func createMessage(text: String) -> ChatMessage {
            ChatMessage(text: text, isSentByUser: true, timestamp: Date(), isDelivered: true)
        }
    }

    class MockReplyService: ReplyServiceProvider {
        func generateReply(for message: ChatMessage) -> AnyPublisher<ChatMessage, Never> {
            let reply = ChatMessage(text: "Mock reply to: \(message.text)", isSentByUser: false, timestamp: Date())
            return Just(reply)
                .delay(for: .milliseconds(100), scheduler: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    }

    var cancellables = Set<AnyCancellable>()

    func testSendMessageAppendsMessage() {
        let viewModel = ChatViewModel(
            sendMessageUseCase: DefaultSendMessageUseCase(service: MockSendService()),
            replyMessageUseCase: DefaultReplyMessageUseCase(service: MockReplyService())
        )

        viewModel.currentInput = "Hello"
        viewModel.sendMessage()

        XCTAssertEqual(viewModel.messages.count, 1)
        XCTAssertEqual(viewModel.messages.first?.text, "Hello")
        XCTAssertTrue(viewModel.messages.first?.isDelivered ?? false)
    }

    func testReplyMessageGetsAppended() {
        let expectation = XCTestExpectation(description: "Reply received")

        let viewModel = ChatViewModel(
            sendMessageUseCase: DefaultSendMessageUseCase(service: MockSendService()),
            replyMessageUseCase: DefaultReplyMessageUseCase(service: MockReplyService())
        )

        viewModel.currentInput = "Hi"
        viewModel.sendMessage()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            XCTAssertEqual(viewModel.messages.count, 2)
            XCTAssertEqual(viewModel.messages.last?.text, "Mock reply to: Hi")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func testReadStatusChangesAfterDelay() {
        let expectation = XCTestExpectation(description: "Message marked read")

        let viewModel = ChatViewModel(
            sendMessageUseCase: DefaultSendMessageUseCase(service: MockSendService()),
            replyMessageUseCase: DefaultReplyMessageUseCase(service: MockReplyService())
        )

        viewModel.currentInput = "Check read"
        viewModel.sendMessage()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            XCTAssertTrue(viewModel.messages.first?.isRead == true)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
    }
}
