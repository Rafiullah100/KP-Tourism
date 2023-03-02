//
//  NewsFeedModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/1/23.
//

import Foundation

struct NewsFeedModel: Codable {
    let feeds: [FeedModel]
}

// MARK: - Feed
struct FeedModel: Codable {
    let description, type: String
    let commentsCount, likesCount, id: Int
    let users: FeedUsersModel
    let postImages: [PostImageModel]

    enum CodingKeys: String, CodingKey {
        case description, type, commentsCount, likesCount, id, users
        case postImages = "post_images"
    }
}

// MARK: - PostImage
struct PostImageModel: Codable {
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
    }
}

// MARK: - Users
struct FeedUsersModel: Codable {
    let name, profileImage: String

    enum CodingKeys: String, CodingKey {
        case name
        case profileImage = "profile_image"
    }
}
