//
//  FollowingModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/28/23.
//

import Foundation

//struct FollowingModel: Codable {
//    let chatUsers: FollowingChatUsers?
//}
//
//// MARK: - ChatUsers
//struct FollowingChatUsers: Codable {
//    let count: Int?
//    let rows: [FollowingRow]?
//}
//
//// MARK: - Row
//struct FollowingRow: Codable {
//    let id: Int?
//    let followingUser: FollowingUser?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case followingUser = "following_user"
//    }
//}
//
//// MARK: - FollowingUser
//struct FollowingUser: Codable {
//    let id: Int?
//    let name, profileImage, profileImageThumb, uuid: String?
//    let country, city: String?
//    let about: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case profileImage = "profile_image"
//        case profileImageThumb = "profile_image_thumb"
//        case uuid, country, city, about
//    }
//}


struct FollowingModel: Codable {
    let chatUsers: FollowingChatUsers?
}

// MARK: - ChatUsers
struct FollowingChatUsers: Codable {
    let count: Int?
    let rows: [FollowingRow]?
}

// MARK: - Row
struct FollowingRow: Codable {
    let id: Int?
    let followingUser: FollowingUser?

    enum CodingKeys: String, CodingKey {
        case id
        case followingUser = "following_user"
    }
}

// MARK: - FollowingUser
struct FollowingUser: Codable {
    let id: Int?
    let name, profileImage, profileImageThumb, uuid: String?
    let country, city: String?
    let about: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case profileImage = "profile_image"
        case profileImageThumb = "profile_image_thumb"
        case uuid, country, city, about
    }
}
