//
//  Untitled.swift
//  EqualExpertTest
//
//  Created by Aklesh Rathaur on 28/06/25.
//

import SwiftUI
import Combine

protocol ReplyServiceProvider {
    func generateReply(for message: ChatMessage) -> AnyPublisher<ChatMessage, Never>
}

final class DefaultReplyService: ReplyServiceProvider {
    func generateReply(for message: ChatMessage) -> AnyPublisher<ChatMessage, Never> {
        let reply = ChatMessage(text: "Auto-reply to: \(message.text)", isSentByUser: false, timestamp: Date())
        return Just(reply)
            .delay(for: .seconds(3), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
