//
//  NewsFeedModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/1/23.
//

import Foundation



//****************************************

////
struct NewsFeedModel: Codable {
    let count: Int
    let feeds: [FeedModel]
}

// MARK: - Feed
struct FeedModel: Codable {
    let updatedAt, description, type: String
    let commentsCount, likesCount, id: Int
    let users: FeedUsers
    let postFiles: [PostImageModel]

    enum CodingKeys: String, CodingKey {
        case updatedAt, description, type, commentsCount, likesCount, id, users
        case postFiles = "post_files"
    }
}

// MARK: - PostFile
struct PostImageModel: Codable {
    let title, imageURL: String
    let videoURL: String?

    enum CodingKeys: String, CodingKey {
        case title
        case imageURL = "image_url"
        case videoURL = "video_url"
    }
}

// MARK: - Users
struct FeedUsers: Codable {
    let id: Int
    let name, profileImage, profileImageThumb: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case profileImage = "profile_image"
        case profileImageThumb = "profile_image_thumb"
    }
}
