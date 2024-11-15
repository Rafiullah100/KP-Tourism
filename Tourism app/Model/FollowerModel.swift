//
//  FollowerModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 5/14/23.
//

import Foundation

struct FollowerModel: Codable {
    let success: Bool?
    let followers: Followers
    let message: String?
}

// MARK: - Followers
struct Followers: Codable {
    let count: Int?
    let rows: [FollowerRow]
}

// MARK: - Row
struct FollowerRow: Codable {
    let createdAt: String?
    let id, followerID, followingID, isFollowing: Int?
    let followerUser: FollowerUser

    enum CodingKeys: String, CodingKey {
        case createdAt, id
        case followerID = "follower_id"
        case followingID = "following_id"
        case isFollowing
        case followerUser = "following_user"
    }
}

// MARK: - FollowingUser
struct FollowerUser: Codable {
    let id: Int?
    let name, profileImage, profileImageThumb, uuid: String?
    let country: String?
    let city: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case profileImage = "profile_image"
        case profileImageThumb = "profile_image_thumb"
        case uuid, country, city
    }
}
