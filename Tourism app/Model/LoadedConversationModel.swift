//
//  User.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/15/23.
//

import Foundation

//struct LoadedConversationModel: Codable {
//    let userConversations: [UserConversation]
//}
//
//// MARK: - UserConversation
//struct UserConversation: Codable {
//    let conversationID: Int
//    let user: ChatUserRow
//
//    enum CodingKeys: String, CodingKey {
//        case conversationID = "conversation_id"
//        case user
//    }
//}

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

//struct LoadedConversationModel: Codable {
//    let userConversations: [UserConversation]
//}
//
//// MARK: - UserConversation
//struct UserConversation: Codable {
//    let conversationID: Int
//    let user: ConversationUser
//
//    enum CodingKeys: String, CodingKey {
//        case conversationID = "conversation_id"
//        case user
//    }
//}
//
//struct ConversationUser: Codable {
//    let id: Int
//    let uuid: String
//    let name: String?
//    let profileImage, profileImageThumb: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, uuid, name
//        case profileImage = "profile_image"
//        case profileImageThumb = "profile_image_thumb"
//    }
//}



struct LoadedConversationModel: Codable {
    let count: Int?
    let userConversations: [LoadedConversation]?
}

// MARK: - UserConversation
struct LoadedConversation: Codable {
    let conversationID: Int?
    let user: LoadedConversationUser?

    enum CodingKeys: String, CodingKey {
        case conversationID = "conversation_id"
        case user
    }
}

// MARK: - User
struct LoadedConversationUser: Codable {
    let id: Int?
    let uuid, name, profileImage, profileImageThumb: String?

    enum CodingKeys: String, CodingKey {
        case id, uuid, name
        case profileImage = "profile_image"
        case profileImageThumb = "profile_image_thumb"
    }
}
