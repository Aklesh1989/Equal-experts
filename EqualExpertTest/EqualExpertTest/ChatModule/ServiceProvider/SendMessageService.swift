//
//  Untitled.swift
//  EqualExpertTest
//
//  Created by Aklesh Rathaur on 28/06/25.
//

import SwiftUI

protocol SendMessageServiceProvider {
    func createMessage(text: String) -> ChatMessage
}

final class DefaultSendMessageService: SendMessageServiceProvider {
    func createMessage(text: String) -> ChatMessage {
        ChatMessage(text: text, isSentByUser: true, timestamp: Date(), isDelivered: true)
    }
}
