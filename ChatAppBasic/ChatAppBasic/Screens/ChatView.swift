
import SwiftUI

struct ChatView: View {
    @ObservedObject var Services: ChatSocketService
    let peerName: String
    @State private var TextMessage: String = ""
    var body: some View {
        VStack {
            headerView
            Divider()
            messagesView
            Divider()
            messageInputView
        }
        .onAppear {
            Services.presentinChatScreen(val: true)
            Services.markMessageAsSeen()
        }
        .onDisappear {
            Services.presentinChatScreen(val: false)
        }
    }
    private var headerView: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .font(.title)

            VStack(alignment: .leading) {
                Text(Services.nextPerson.first ?? peerName)
                    .font(.title)

                Text(Services.peerOnline ? "Online" : "Offline")
                    .foregroundStyle(
                        Services.peerOnline ? Color.green : Color.gray
                    )

                Text(Services.isType ? "typing..." : "")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            Spacer()
        }
    }
    
    private var messagesView: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(Services.messages) { message in
                        messageRow(message)
                    }
                }
                .padding(.vertical)
            }
            .onChange(of: Services.messages.count) { _, _ in
                if let last = Services.messages.last {
                    withAnimation { proxy.scrollTo(last.id, anchor: .bottom) }
                    if !last.isMe { Services.markMessageAsSeen() }
                }
            }
        }
    }
    
    private func messageRow(_ message: MessageModel) -> some View {
        HStack {
            if message.isMe {
                Spacer(minLength: 50)
            }
            VStack(alignment: message.isMe ? .trailing : .leading, spacing: 5) {
                messageBubble(message)
                messageStatus(message)
            }
            if !message.isMe {
                Spacer(minLength: 50)
            }
        }
        .padding(.vertical)
        .padding(.horizontal)
        .id(message.id)
        .onAppear {
            print("Message", message)
        }
    }
    
    private func messageBubble(_ message: MessageModel) -> some View {
        Text(message.content)
            .padding(12)
            .background(message.isMe ? Color.blue : Color.gray.opacity(0.2))
            .foregroundStyle(message.isMe ? .white : .primary)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private func messageStatus(_ message: MessageModel) -> some View {
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
                    .foregroundStyle(message.seen ? .cyan : .gray)
            }
        }
    }
    
    private func scrollToLastMessage(_ proxy: ScrollViewProxy) {
        guard let lastMessage = Services.messages.last else {
            return
        }

        withAnimation {
            proxy.scrollTo(lastMessage.id, anchor: .bottom)
        }
    }
    
    private var messageInputView: some View {
        HStack {
            TextField("Message:", text: $TextMessage)
                .textFieldStyle(.roundedBorder)
                .onChange(of: TextMessage) { _, newValue in
                    Services.typing(isType: !newValue.isEmpty)
                }

            Button {
                MessageSending()
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundStyle(.white)
                    .padding(12)
                    .background(Color.black)
                    .clipShape(Circle())
            }
            .disabled(
                TextMessage.trimmingCharacters(
                    in: .whitespacesAndNewlines
                ).isEmpty
            )
        }
    }
    
    private func MessageSending() {
        let text = TextMessage.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !text.isEmpty else {
            return
        }

        Services.sendMessage(message: text)
        TextMessage = ""
        Services.typing(isType: false)
    }
}

#Preview {
    ChatView(
        Services: ChatSocketService(),
        peerName: ""
    )
}
