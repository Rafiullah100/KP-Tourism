//
//  SocketHelper.swift
//  Socket_demo
//
//  Created by Krishna Soni on 06/12/19.
//  Copyright © 2019 Krishna Soni. All rights reserved.
//

import UIKit
import Foundation
import SocketIO

let kHost = "https://staging-admin.kptourism.com?"

let kConnectUser = "connectUser"
let kUserList = "userList"
let kExitUser = "exitUser"


final class SocketHelper: NSObject {
    
    static let shared = SocketHelper()
    
    private var socket: SocketIOClient?
    var manager: SocketManager?

    override init() {
        super.init()
        configureSocketClient()
    }
    
    private func configureSocketClient() {
        
        guard let url = URL(string: kHost) else {
            return
        }
        print(url)
        manager = SocketManager(socketURL: url, config: [.log(true), .connectParams(["uuid": UserDefaults.standard.uuid ?? ""])])
        socket = manager?.defaultSocket
    }
    
    func establishConnection() {
        
        DispatchQueue.main.async {
            guard let socket = self.manager?.defaultSocket else{
                return
            }
            socket.on(clientEvent: .connect) {data, ack in
                print("socket connected")
            }
            socket.connect()
        }
    }
    
    func closeConnection() {
        
//        guard let socket = manager?.defaultSocket else{
//            return
//        }
//
        socket?.disconnect()
    }
    
//    func joinChatRoom(nickname: String, completion: () -> Void) {
//
//        guard let socket = manager?.defaultSocket else {
//            return
//        }
//
//        socket.emit(kConnectUser, nickname)
//        completion()
//    }
//
//    func leaveChatRoom(nickname: String, completion: () -> Void) {
//
//        guard let socket = manager?.defaultSocket else{
//            return
//        }
//
//        socket.emit(kExitUser, nickname)
//        completion()
//    }
    
//    func participantList(completion: @escaping (_ userList: [User]?) -> Void) {
//
//        guard let socket = manager?.defaultSocket else {
//            return
//        }
//
//        socket.on(kUserList) { [weak self] (result, ack) -> Void in
//
//            guard result.count > 0,
//                let _ = self,
//                let user = result.first as? [[String: Any]],
//                let data = UIApplication.jsonData(from: user) else {
//                    return
//            }
//
//            do {
//                let userModel = try JSONDecoder().decode([User].self, from: data)
//                completion(userModel)
//
//            } catch let error {
//                print("Something happen wrong here...\(error)")
//                completion(nil)
//            }
//        }
//
//    }
    
    func getMessage(completion: @escaping (_ message: String?, _ from: String?) -> Void) {
        socket?.on(Constants.socketEvent) { (dataArray, socketAck) -> Void in
            if let responseArray = dataArray as? [[String: Any]],
               let firstResponse = responseArray.first,
               let message = firstResponse["message"] as? [String: Any],
               let content = message["content"] as? String, let from = firstResponse["from"] as? String {
                completion(content, from)
            } else {
                print("Invalid response format or missing content")
            }
        }
    }
    
//    func sendMessage(message: String, to: String) {
//        socket?.emit(Constants.socketEvent, ["to": to, "message": message])
//    }
    
    func typeListening(completion: @escaping (String?) -> Void) {
        socket?.on(Constants.socketTypingEvent) { (data, socketAck) -> Void in
            if let dataArray = data as? [[String: Any]], let firstData = dataArray.first {
                if let from = firstData["from"] as? String, let message = firstData["message"] as? String {
                    print(from)
                    completion(message)
                }
            }
        }
    }
    
    func typeEmiting(to: String){
        print(to)
        socket?.emit(Constants.socketTypingEvent, ["to": to])
    }
    
    func sendMessage(uuid: String, conversationID: Int, message: String){
        //        socket?.emit(Constants.socketTypingEvent, ["to": to])
        print(uuid, UserDefaults.standard.uuid ?? "")
        let senderDict: [String: Any] = [
            "profile_image_thumb": UserDefaults.standard.profileImage ?? "",
            "uuid": "\(UserDefaults.standard.uuid ?? "")"
        ]
        
        let messageDict: [String: Any] = [
            "content": message,
            "conversation_id": conversationID,
            "createdAt": "a few seconds ago",
            "id": 0,
            "is_read": false,
            "is_seen": false,
            "receiver_id": 0,
            "sender": senderDict,
            "sender_id": UserDefaults.standard.userID ?? 0,
            "updatedAt": "a few seconds ago"
        ]
        
        let jsonObject: [String: Any] = [
            "to": uuid,
            "message": messageDict
        ]
        print(jsonObject)
        socket?.emit(Constants.socketEvent, jsonObject)
    }
}
