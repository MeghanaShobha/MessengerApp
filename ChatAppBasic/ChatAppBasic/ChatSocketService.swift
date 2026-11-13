import SwiftUI
import Combine
import SocketIO

struct MessageModel: Identifiable, Codable {
    var id: Int
    var name: String
    var content: String
    var isMe: Bool
    var seen: Bool
    var time: Double

    var date: Date {
        Date(timeIntervalSince1970: time / 1000)
    }
}

final class ChatSocketService: ObservableObject {

    @Published var nextPerson: [String] = []
    @Published var messages: [MessageModel] = []
    @Published var isConnected = false
    @Published var secondPerson: String = ""
    @Published var isType = false
    @Published var peerOnline = false
    @Published var currentUserId: String = ""

    private var seenMessageIDs = Set<Int>()
    private var socket: SocketIOClient!
    private var manager: SocketManager!

    init() {
        manager = SocketManager(
            socketURL: URL(string: "https://rethink-overlabor-excitable.ngrok-free.dev")!,
            config: [
                .log(true),
                .compress,
                .forceWebsockets(true),
                .extraHeaders(["ngrok-skip-browser-warning": "true"])
            ]
        )

        socket = manager.defaultSocket
        Events()
    }

    func Events() {

        socket.on(clientEvent: .connect) { [weak self] data, ack in
            DispatchQueue.main.async {
                self?.isConnected = true
                print("Socket is connected")
            }
        }

        socket.on(clientEvent: .disconnect) { [weak self] data, ack in
            DispatchQueue.main.async {
                self?.isConnected = false
                self?.peerOnline = false
                self?.isType = false
                self?.nextPerson.removeAll()
                self?.secondPerson = ""
                self?.messages.removeAll()
            }
        }

        socket.on("message") { [weak self] data, ack in
            guard let self,
                  var message = self.decodes(MessageModel.self, from: data) else { return }
            DispatchQueue.main.async {
                message.isMe = (message.name == self.currentUserId)
                self.messages.append(message)
                if !message.isMe { self.secondPerson = message.name }
            }
        }
        

        socket.on("typing") { [weak self] data, ack in
            guard let info = data.first as? [String: Any],
                  let isTyping = info["isType"] as? Bool
            else {
                print("Typing data format is incorrect")
                return
            }

            DispatchQueue.main.async {
                self?.isType = isTyping
            }
        }

        socket.on("user:online") { [weak self] data, ack in
            DispatchQueue.main.async {
                self?.peerOnline = true
                print("Other user is online")
            }
        }

        socket.on("user:offline") { [weak self] data, ack in
            DispatchQueue.main.async {
                self?.peerOnline = false
                print("Other user is offline")
            }
        }

        socket.on("seen") { [weak self] data, ack in
            guard let self,
                  data.first as? Bool == true else {
                return
            }

            DispatchQueue.main.async {
                for index in self.messages.indices where self.messages[index].isMe {
                    self.messages[index].seen = true
                }
            }
        }

        socket.on("online:names") { [weak self] data, ack in
            guard let self else { return }
            let names = data.first as? [String] ?? []
            DispatchQueue.main.async {
                let others = names.filter { $0 != self.currentUserId }
                self.nextPerson = others
                if let first = others.first { self.secondPerson = first }  // keep last name when they go offline
                self.peerOnline = !others.isEmpty
            }
        }
    }

    func connect(userId: String) {
        currentUserId = userId
        socket.connect(withPayload: ["userId": userId])
        print("Connecting user:", userId)
    }

    func disconnect() {
        socket.disconnect()

        DispatchQueue.main.async {
            self.isConnected = false
            self.peerOnline = false
            self.isType = false
            self.nextPerson.removeAll()
        }

        print("User disconnected")
    }

    func sendMessage(message: String) {
        emit("message", item: message)
        print("Message sent:", message)
    }

    func emit(_ event: String, item: SocketData) {
        socket.emit(event, item)
    }

    func typing(isType: Bool) {
        emit("typing", item: isType)
    }

    func markMessageAsSeen() {
        socket.emit("seen", true)
    }

    func presentinChatScreen(val: Bool) {
        emit("present", item: val)
        socket.emit("online:names")
        print("Chat screen status:", val)
    }

    func decodes<T: Decodable>(_ type: T.Type, from data: [Any]) -> T? {
        guard let json = data.first,
              let bytes = try? JSONSerialization.data(withJSONObject: json)
        else {
            print("JSON conversion failed")
            return nil
        }

        do {
            return try JSONDecoder().decode(T.self, from: bytes)
        } catch {
            print("JSON decoding error:", error)
            return nil
        }
    }
}
