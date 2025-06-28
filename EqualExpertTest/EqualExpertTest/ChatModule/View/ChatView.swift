//
//  ChatView.swift
//  EqualExpertTest
//
//  Created by Aklesh Rathaur on 28/06/25.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel: ChatViewModel

    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEach(viewModel.messages) { message in
                                HStack(alignment: .bottom) {
                                    if message.isSentByUser { Spacer() }
                                    VStack(alignment: message.isSentByUser ? .trailing : .leading, spacing: 2) {
                                        Text(message.text)
                                            .padding(10)
                                            .background(message.isSentByUser ? Color.blue : Color.gray.opacity(0.4))
                                            .foregroundColor(.white)
                                            .cornerRadius(12)

                                        if message.isSentByUser {
                                            HStack(spacing: 2) {
                                                MessageStatusView(isDelivered: message.isDelivered, isRead: message.isRead)
                                            }
                                        }
                                    }
                                    if !message.isSentByUser { Spacer() }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .onChange(of: viewModel.messages.count) {
                        if let lastID = viewModel.messages.last?.id {
                            withAnimation {
                                proxy.scrollTo(lastID, anchor: .bottom)
                            }
                        }
                    }
                }

                HStack {
                    TextField("Type a message", text: $viewModel.currentInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .accessibilityIdentifier("Type a message")
                    Button("Send") {
                        viewModel.sendMessage()
                    }
                    .accessibilityIdentifier("Send")
                    .disabled(viewModel.currentInput.isEmpty)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                        Text("Chat with Alex")
                            .font(.headline)
                    }
                }
            }
        }
    }
}


#Preview {
    let sendService = DefaultSendMessageService()
            let replyService = DefaultReplyService()
            let sendUseCase = DefaultSendMessageUseCase(service: sendService)
            let replyUseCase = DefaultReplyMessageUseCase(service: replyService)
            let viewModel = ChatViewModel(sendMessageUseCase: sendUseCase, replyMessageUseCase: replyUseCase)
    ChatView(viewModel:viewModel)
}


