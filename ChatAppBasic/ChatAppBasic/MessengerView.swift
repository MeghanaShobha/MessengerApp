//
//  MessengerView.swift
//  ChatAppBasic
//
//  Created by Meghana IOS on 03/11/26.
//

import SwiftUI

struct MessengerView: View {
    @StateObject private var chatManager = ChatSocketManager.shared
    @State private var message = ""

    var body: some View {
        VStack {
            Text("One-to-One Chat")
                .font(.title2)
                .bold()
                .padding()

            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(chatManager.messages) { chat in
                        HStack {
                            if chat.isSentByMe {
                                Spacer()
                            }

                            Text(chat.text)
                                .padding()
                                .background(
                                    chat.isSentByMe
                                    ? Color.blue
                                    : Color.gray.opacity(0.2)
                                )
                                .foregroundStyle(
                                    chat.isSentByMe ? .white : .primary
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 15))

                            if !chat.isSentByMe {
                                Spacer()
                            }
                        }
                    }
                }
                .padding()
            }

            HStack {
                TextField("Type a message...", text: $message)
                    .textFieldStyle(.roundedBorder)

                Button("Send") {
                    sendMessage()
                }
                .disabled(
                    message.trimmingCharacters(in: .whitespaces).isEmpty
                )
            }
            .padding()
        }
        .onAppear {
            chatManager.connect()
        }
    }

    func sendMessage() {
        let text = message.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !text.isEmpty else { return }

        chatManager.sendMessage(text)
        message = ""
    }
}

#Preview {
    MessengerView()
}
