//
//  ChatSocketService.swift
//  MessengerApp
//
//  Created by Meghana IOS on 04/11/26.
//

import SwiftUI
import SocketIO
import Combine

struct ChatMessage:Identifiable {
    let id: String
    let name: String
    let content: String
    let isMe: Bool
    let seen: Bool
    let time:TimeInterval
}
final class ChatSocketService: ObservableObject{
    @Published var messages: [ChatMessage] = []
    @Published var isConnected = false
    @Published var peerIsOnline = false
    
    private var manager :SocketManager!
    private var socket:SocketIOClient!

    init(){
        manager = SocketManager(
            socketURL:  URL(string: "https://0127-2401-4900-91d2-5c78-f4f0-c0e4-97ce-6ef5.ngrok-free.app")!,
            config: [.log(true),.compress]
        )
        socket = manager.defaultSocket
        setupSocketEvents()
        
    }
  func setupSocketEvents() {
        socket.on(clientEvent: .connect){[weak self] data,ack in
            DispatchQueue.main.async {
                self?.isConnected = true
                print("socket connected")
            }
        }
        
        socket.on(clientEvent: .disconnect){[weak self] data,ack in
            DispatchQueue.main.async {
                self?.isConnected = false
                print("socket is disconnected")
            }
        }
        
//        socket.on("chat:receive"){[weak self] data, ack in
//            guard let self = self,
//                  let messageData = data.first as? [String:Any] else{
//                return
//            }
//        let message = self.createMessage(from: messageData)
//            DispatchQueue.main.async {
//                self.messages.append(message)
//            }
//        }
    }
    func sendMessage(_ text:String){
        let message : [String:Any] = [
            "id": UUID().uuidString,
            "name":"Me",
            "content":text,
            "isMe":true,
            "seen":false,
            "time":Date().timeIntervalSince1970
            
        ]
        socket.emit("send_message",message)
    }
    private func createMessage(from data: [String:Any])->ChatMessage{
        return ChatMessage(
            id: data["id"] as? String ?? UUID().uuidString,
            name: data["name"] as? String ?? "unknow",
            content: data["content"] as? String ?? "",
            isMe: data["isMe"] as? Bool ?? false,
            seen: data["seen"] as? Bool ?? false,
            time: data["time"] as? TimeInterval ?? Date().timeIntervalSince1970
        )
    }
    
    func connect(){
        socket.connect()
        
    }
    func disconnect(){
        socket.disconnect()
    }
    
}

//#Preview {
//    ChatSocketService()
//}
