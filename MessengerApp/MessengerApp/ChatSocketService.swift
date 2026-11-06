//
//  ChatSocketService.swift
//  MessengerApp
//
//  Created by Meghana IOS on 04/11/26.
//

import SwiftUI
import SocketIO
import Combine

struct ChatMessage:Identifiable,Codable {
    var id: Int // pehle UUID tha, ab Int
    var name: String = ""
    var content: String
    var isMe: Bool = false
    var seen: Bool = false
    var time: Double = 0 // milliseconds
    var date: Date { Date(timeIntervalSince1970: time / 1000) }
}

final class ChatSocketService: ObservableObject{
    @Published var messages: [ChatMessage] = []
    @Published var isConnected = false
    @Published var peerIsOnline = false
    @Published var secondPerson:String = ""
    @Published var nextPerson: [String] = []
    @Published var isType = false
    private var seenMessageIDs = Set<Int>()
    private var manager :SocketManager!
    private var socket:SocketIOClient!
    
    
    init(){
        manager = SocketManager(
            socketURL:  URL(string: "https://0f40-111-92-91-96.ngrok-free.app")!,
            config: [.log(true),.compress]
        )
        socket = manager.defaultSocket
        setupSocketEvents()
        
    }
    
    
    //Socket Events
    func setupSocketEvents(){
        socket.on(clientEvent: .connect){
            [weak self] data, ack in
            DispatchQueue.main.async{
                self?.isConnected = true
                print("Socket is connected")
            }
        }
        
        
        socket.on(clientEvent: .disconnect){
            [weak self] Data, ack in
            DispatchQueue.main.async{
                self?.isConnected = false
                print("Socket is disconnected")
            }
        }
        
        socket.on("message") { [weak self] data, ack in
            guard let self,
                  let message = self.decodes(ChatMessage.self, from: data) else {
                print("Message decoding failed:", data)
                return
            }
            DispatchQueue.main.async {
                self.messages.append(message)
                print("Received message:", message)
                if !message.isMe {
                    self.secondPerson = message.name
                }
            }
        }
        
        socket.on("seen") { [weak self] data, _ in
        guard let self, data.first as? Bool == true else { return }
        for i in messages.indices where messages[i].isMe { messages[i].seen = true }
        }
        
        socket.on("user:online") { [weak self] data, ack in
            DispatchQueue.main.async {
                self?.peerIsOnline = true
            }
        }
        
        socket.on("user:offline"){[weak self] data, ack in
            DispatchQueue.main.async {
                self?.peerIsOnline = false
            }
        }
        
        socket.on("typing") { [weak self] data, ack in
            guard let info = data.first as? [String: Any] else {
                return
            }
            guard let isTyping = info["isTyping"] as? Bool else {
                return
            }
            DispatchQueue.main.async {
                self?.isType = isTyping
            }
        }
        
        socket.on("online:names") { [weak self] data,ack in
            self?.nextPerson = data.first as? [String] ?? []
            print("online:names ->", data, "| otherNames:", self?.nextPerson ?? [])
        }
        
        
    }
    
    
    
    
    
    func connect(userId: String) {
        socket.connect(withPayload:["userId": userId])
    }
    func disconnect(){
        socket.disconnect()
    }
    func sendMessage(message:String){
        emit("message",item: message)
    }
    
    func typing (isType : Bool) {
        emit("typing", item: isType)
    }
    
    func emit(_ event:String,item:SocketData){
        socket.emit(event,item)
    }
    func decodes<T: Decodable>(_ type: T.Type, from data: [Any]) -> T? {
        guard let json = data.first,
              let bytes = try? JSONSerialization.data(withJSONObject: json) else { return nil }
        return try? JSONDecoder().decode(T.self, from: bytes)
    }
    func presentinChatScreen(val : Bool){
        emit("present",item: val)
        socket.emit("online:names")
    }
//    func markMessageAsSeen(messageId: Int) {
//        guard !seenMessageIDs.contains(messageId) else { return }
//        seenMessageIDs.insert(messageId)
//        socket.emit("seen", true)
//        print(messageId)
//        print("Seen event emitted:", messageId)
//    }
    
    func markMessageAsSeen() { socket.emit("seen", true) } // guard aur seenMessageIDs hata do
//    .onAppear {
//    chatService.presentinChatScreen(val: true)
//    chatService.markMessageAsSeen() // har baar chat khulne par
//    }
    
}


//#Preview {
//    ChatSocketService()
//}
