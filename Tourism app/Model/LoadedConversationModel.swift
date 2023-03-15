//
//  User.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/15/23.
//

import Foundation

struct LoadedConversationModel: Codable {
    let userConversations: [UserConversation]
}

// MARK: - UserConversation
struct UserConversation: Codable {
    let conversationID: Int
    let user: ChatUserRow

    enum CodingKeys: String, CodingKey {
        case conversationID = "conversation_id"
        case user
    }
}

// MARK: - User
//struct UserConversationRow: Codable {
//    let id: Int
//    let uuid, name, profileImage: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, uuid, name
//        case profileImage = "profile_image"
//    }
//}
