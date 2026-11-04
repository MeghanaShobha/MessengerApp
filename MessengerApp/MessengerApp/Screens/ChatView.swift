//
//  ChatView.swift
//  MessengerApp
//
//  Created by Meghana IOS on 03/11/26.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var chatService: ChatSocketService
    @State private var messageText = ""
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.blue)
                VStack(alignment: .leading) {
                    Text("Yashu")
                        .font(.title)
                    Text(chatService.peerIsOnline ? "Online" : "Offline")
                        .font(.caption)
                        .foregroundStyle(chatService.peerIsOnline ? .green : .gray)
                }
                Spacer()
                Circle()
                    .fill(chatService.isConnected ? .green : .gray)
                    .frame(width: 10, height: 10)
            }
            .padding()
            Divider()
            
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 15) {
                        ForEach(chatService.messages, id: \.id) { message in
                            HStack {
                                if message.isMe {
                                    Spacer(minLength: 50)
                                }
                                VStack(alignment: .trailing, spacing: 5) {
                                    Text(message.content)
                                        .padding(12)
                                        .background(
                                            message.isMe ? Color.blue : Color.gray.opacity(0.2)
                                        )
                                        .foregroundStyle(
                                            message.isMe ? .white : .primary
                                        )
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 12)
                                        )

                                    HStack(spacing: 5) {
                                        Text(
                                            Date(
                                                timeIntervalSince1970: message.time / 1000
                                            ),
                                            style: .time
                                        )
                                        .font(.caption2)

                                        if message.isMe {
                                            Text(message.seen ? "✓✓" : "✓")
                                                .font(.caption)
                                                .foregroundStyle(
                                                    message.seen ? .cyan : .gray
                                                )
                                        }
                                    }
                                }
                                if !message.isMe {
                                    Spacer(minLength: 50)
                                }
                            }
                            .padding(.horizontal)
                            .id(message.id)
                        }
                    }
                    .padding(.vertical)
                }
                .onChange(of: chatService.messages.count) { _, _ in
                    if let lastMessage = chatService.messages.last {
                        withAnimation {
                            proxy.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
                }
            }
            Divider()
            
            HStack {
                TextField("Message", text: $messageText)
                    .textFieldStyle(.roundedBorder)
                Button {
                    sendMessage()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundStyle(.white)
                        .padding(12)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
                .disabled(
                    messageText.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    ).isEmpty
                )
            }
            .padding()
        }
    }

    func sendMessage() {
        let text = messageText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        guard !text.isEmpty else { return }
        chatService.sendMessage(text)
        messageText = ""
    }
}

#Preview {
    ChatView(chatService: ChatSocketService())
}
