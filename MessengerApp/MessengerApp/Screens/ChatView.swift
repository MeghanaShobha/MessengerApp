//
//  ChatView.swift
//  MessengerApp
//
//  Created by Meghana IOS on 03/11/26.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var chatService: ChatSocketService
    let peerName : String
    @State private var messageText = ""
    @State private var messageToEdit: ChatMessage?
    @State private var editedText = ""
//    @State private var secondPerson = ""
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.blue)
                VStack(alignment: .leading) {
                    Text(chatService.nextPerson[0])
                        .font(.title)
                    Text(chatService.peerIsOnline ? "Online" : "Offline")
                        .font(.caption)
                        .foregroundStyle(chatService.peerIsOnline ? .green : .gray)
                    Text(chatService.isType  ? "typing" : "")
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
                                        .contextMenu {
                                                if message.isMe {
                                                    Button {
                                                        editedText = message.content
                                                        messageToEdit = message
                                                    } label: {
                                                        Label("Edit", systemImage: "pencil")
                                                    }
                                                }
                                            }

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
                    .sheet(item: $messageToEdit){message in
                        NavigationStack{
                            Form{
                                TextField("Edit message",text:$editedText)
                                    .onChange(of: editedText) { oldValue, newValue in
                                            print("Old message:", oldValue)
                                            print("New message:", newValue)
                                        }
                            }
                            .navigationTitle(Text("Edit message"))
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Cancel") {
                                        messageToEdit = nil
                                    }
                                }
                            }
                            
                        }
                        
                        
                    }
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
                    .onChange(of: messageText) {
                        if messageText != "" {
                            chatService.typing(isType: true)
                        }
                    }
                Button {
                    sendMessage()
//                    chatService.sendMessage(text)
                    
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
        .onAppear {
            chatService.presentinChatScreen(val: true)
        }
        .onDisappear {
            chatService.presentinChatScreen(val: false)
        }
    }

    func sendMessage() {
        let text = messageText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        guard !text.isEmpty else { return }
        chatService.sendMessage(message: text)
        messageText = ""
        chatService.typing(isType: false)
    }
}

#Preview {
    ChatView(chatService: ChatSocketService(),peerName: "Yashu")
}
