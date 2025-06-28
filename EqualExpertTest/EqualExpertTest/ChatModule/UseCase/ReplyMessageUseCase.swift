//
//  Untitled 2.swift
//  EqualExpertTest
//
//  Created by Aklesh Rathaur on 28/06/25.
//

import SwiftUI
import Combine


protocol ReplyMessageUseCaseProtocol {
    func execute(for message: ChatMessage) -> AnyPublisher<ChatMessage, Never>
}

final class DefaultReplyMessageUseCase: ReplyMessageUseCaseProtocol {
    private let service: ReplyServiceProvider

    init(service: ReplyServiceProvider) {
        self.service = service
    }

    func execute(for message: ChatMessage) -> AnyPublisher<ChatMessage, Never> {
        service.generateReply(for: message)
    }
}
