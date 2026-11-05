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
    @Published var nextPerson: [String] = [" "]
    @Published var isType = false
    private var manager :SocketManager!
    private var socket:SocketIOClient!

    init(){
        manager = SocketManager(
            socketURL:  URL(string: "https://bf00-106-51-65-110.ngrok-free.app")!,
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
        
        socket.on("message") { [weak self] data,ack in
            guard let self, let message = self.decodes(ChatMessage.self, from: data) else { return }
            self.messages.append(message)
//            if message[0]
            print("message-",messages)
            for i in messages {
                if !i.isMe  {
                    secondPerson = i.name
                    break
                }
            }
        }
        
        
        socket.on("seen"){[weak self]data,ack in
            guard let self,
                  let id = data.first as? Int else {
                print("Invalid seen message ID")
                return
            }
            
            DispatchQueue.main.async {
                guard let index = self.messages.firstIndex(where: { $0.id == id }) else {
                    return
                }
                self.messages[index].seen = true
                print("message\(id) is seen")
            }
        }
        
        socket.on("user:online") { [weak self] data, ack in
            DispatchQueue.main.async {
                self?.peerIsOnline = true
            }
        }
        
        socket.on("user:offline "){[weak self] data, ack in
            DispatchQueue.main.async {
                self?.peerIsOnline = false
            }
        }
        
//        socket.on("online:names"){[weak self] data, ack in
//            DispatchQueue.main.async{
//                self?.nextPerson = data.first as? [String] ?? []
//            }
//            print("another name",self?.nextPerson)
//            
////            print("ee",self?.nextPerson ?? "ntg in array")
//
//        }
        socket.on("typing"){[weak self] data,ack in
            
            self?.isType = true
            
        }
        
        socket.on("online:names") { [weak self] data,ack in
                    self?.nextPerson = data.first as? [String] ?? []
                    print("online:names ->", data, "| otherNames:", self?.nextPerson ?? [])
                }
//
        
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
    
    
}

//#Preview {
//    ChatSocketService()
//}
