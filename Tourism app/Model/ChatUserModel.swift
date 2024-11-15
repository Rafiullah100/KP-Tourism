//
//  ChatUserModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/9/23.
//

import Foundation
//
//struct ChatUserModel: Codable {
//    let chatUsers: ChatUsers
//}
//
//// MARK: - ChatUsers
//struct ChatUsers: Codable {
//    let count: Int
//    let rows: [ChatRow]
//}
//
//// MARK: - Row
//struct ChatRow: Codable {
//    let id: Int
//    let followerUser, followingUser: ChatFollowUser
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case followerUser = "follower_user"
//        case followingUser = "following_user"
//    }
//}
//
//// MARK: - FollowUser
//struct ChatFollowUser: Codable {
//    let id: Int
//    let name, profileImage, uuid: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case profileImage = "profile_image"
//        case uuid
//    }
//}


struct ChatUserModel: Codable {
    let chatUsers: ChatUsers?
}

// MARK: - ChatUsers
struct ChatUsers: Codable {
    let count: Int?
    let rows: [ChatUserRow]?
}

// MARK: - Row
struct ChatUserRow: Codable {
    let id: Int?
    let name: String?
    let profileImage: String?
    let uuid: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case profileImage = "profile_image"
        case uuid
    }
}

