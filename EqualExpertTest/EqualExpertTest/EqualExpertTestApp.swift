//
//  EqualExpertTestApp.swift
//  EqualExpertTest
//
//  Created by Aklesh Rathaur on 27/06/25.
//

import SwiftUI

@main
struct EqualExpertTestApp: App {
    var body: some Scene {
        WindowGroup {
            let sendService = DefaultSendMessageService()
            let replyService = DefaultReplyService()
            let sendUseCase = DefaultSendMessageUseCase(service: sendService)
            let replyUseCase = DefaultReplyMessageUseCase(service: replyService)
            let viewModel = ChatViewModel(sendMessageUseCase: sendUseCase, replyMessageUseCase: replyUseCase)
            ChatView(viewModel: viewModel)
        }
    }
}
