//
//  Untitled.swift
//  EqualExpertTest
//
//  Created by Aklesh Rathaur on 28/06/25.
//

import SwiftUI

protocol SendMessageUseCaseProtocol {
    func execute(_ text: String) -> ChatMessage
}

final class DefaultSendMessageUseCase: SendMessageUseCaseProtocol {
    private let service: SendMessageServiceProvider

    init(service: SendMessageServiceProvider) {
        self.service = service
    }

    func execute(_ text: String) -> ChatMessage {
        service.createMessage(text: text)
    }
}
