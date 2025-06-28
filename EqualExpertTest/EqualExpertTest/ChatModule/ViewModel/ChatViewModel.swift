//
//  Untitled.swift
//  EqualExpertTest
//
//  Created by Aklesh Rathaur on 28/06/25.
//
import SwiftUI
import Combine

protocol ChatViewModelProtocol: ObservableObject {
    var messages: [ChatMessage] { get }
    var currentInput: String { get set }
    func sendMessage()
}

// MARK: - ViewModel Implementation

final class ChatViewModel: ChatViewModelProtocol {
    @Published private(set) var messages: [ChatMessage] = []
    @Published var currentInput: String = ""

    private let sendMessageUseCase: SendMessageUseCaseProtocol
    private let replyMessageUseCase: ReplyMessageUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    init(sendMessageUseCase: SendMessageUseCaseProtocol,
         replyMessageUseCase: ReplyMessageUseCaseProtocol) {
        self.sendMessageUseCase = sendMessageUseCase
        self.replyMessageUseCase = replyMessageUseCase
    }

    func sendMessage() {
        let message = sendMessageUseCase.execute(currentInput)
        messages.append(message)
        currentInput = ""

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if let index = self.messages.firstIndex(where: { $0.id == message.id }) {
                self.messages[index].isRead = true
            }
        }

        replyMessageUseCase.execute(for: message)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] reply in
                self?.messages.append(reply)
            }
            .store(in: &cancellables)
    }
}
