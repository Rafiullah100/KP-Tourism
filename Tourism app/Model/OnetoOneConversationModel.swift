//
//  OnetoOneConversationModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/15/23.
//

import Foundation

struct OnetoOneConversationModel: Codable {
    let chats: OnetoOneConversation
}

// MARK: - Chats
struct OnetoOneConversation: Codable {
    let count: Int
    let rows: [OnetoOneConversationRow]
}

// MARK: - Row
struct OnetoOneConversationRow: Codable {
    let createdAt: String
    let id, conversationID: Int
    let content: String
    let imageURL: String?
    let sender: OnetoOneConversationSender

    enum CodingKeys: String, CodingKey {
        case createdAt, id
        case conversationID = "conversation_id"
        case content
        case imageURL = "image_url"
        case sender
    }
}

// MARK: - Sender
struct OnetoOneConversationSender: Codable {
    let id: Int
    let uuid, name, username, profileImage: String
    let profileImageThumb: String

    enum CodingKeys: String, CodingKey {
        case id, uuid, name, username
        case profileImage = "profile_image"
        case profileImageThumb = "profile_image_thumb"
    }
}
