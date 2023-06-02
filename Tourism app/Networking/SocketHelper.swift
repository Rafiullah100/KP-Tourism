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

let kHost = "https://staging-admin.kptourism.com?uuid=\(UserDefaults.standard.uuid ?? "")"

let kConnectUser = "connectUser"
let kUserList = "userList"
let kExitUser = "exitUser"


final class SocketHelper: NSObject {
    
    static let shared = SocketHelper()
    
    private var socket: SocketIOClient?
    let manager = SocketManager(socketURL: URL(string: kHost)!, config: [.log(false), .compress])

    override init() {
        super.init()
        configureSocketClient()
    }
    
    private func configureSocketClient() {
        
        guard let url = URL(string: kHost) else {
            return
        }
                
        
//        guard let manager = manager else {
//            return
//        }
//
//        socket = manager.socket(forNamespace: "/**********")
    }
    
    func establishConnection() {
        
//        guard let socket = manager.defaultSocket else{
//            return
//        }
        let socket = manager.defaultSocket

        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        socket.connect()
    }
    
    func closeConnection() {
        
//        guard let socket = manager.defaultSocket else{
//            return
//        }
        let socket = manager.defaultSocket
        
        socket.disconnect()
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
    
    func getMessage(completion: @escaping (_ messageInfo: Message?) -> Void) {

        let socket = manager.defaultSocket
        socket.on("user-chat-message") { (dataArray, socketAck) -> Void in
            print("dataArray", dataArray)
        }
    }
    
    func sendMessage(message: String, to: String) {
        let socket = manager.defaultSocket
        socket.emit("user-chat-message", ["to": to, "message": message])
    }
}
