//
//  NewsFeedModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/1/23.
//

import Foundation



//****************************************

////
//struct NewsFeedModel: Codable {
//    let count: Int
//    let feeds: [FeedModel]
//}
//
//// MARK: - Feed
//struct FeedModel: Codable {
//    let updatedAt, description, type: String
//    let commentsCount, likesCount, id: Int
//    let users: FeedUsers
//    let postFiles: [PostImageModel]
//
//    enum CodingKeys: String, CodingKey {
//        case updatedAt, description, type, commentsCount, likesCount, id, users
//        case postFiles = "post_files"
//    }
//}
//
//// MARK: - PostFile
//struct PostImageModel: Codable {
//    let title, imageURL: String
//    let videoURL: String?
//
//    enum CodingKeys: String, CodingKey {
//        case title
//        case imageURL = "image_url"
//        case videoURL = "video_url"
//    }
//}
//
//// MARK: - Users
//struct FeedUsers: Codable {
//    let id: Int
//    let name, profileImage, profileImageThumb: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case profileImage = "profile_image"
//        case profileImageThumb = "profile_image_thumb"
//    }
//}


struct NewsFeedModel: Codable {
    let count: Int?
    let feeds: [FeedModel]?
}

// MARK: - Feed
struct FeedModel: Codable {
    let createdAt, updatedAt: String?
    let id, postID, commentsCount, likesCount: Int?
    let isLiked, isWished: Int?
    let post: FeedPost?
    let user: FeedUsers?

    enum CodingKeys: String, CodingKey {
        case createdAt, updatedAt, id
        case postID = "post_id"
        case commentsCount, likesCount, isLiked, isWished, post, user
    }
}

// MARK: - Post
struct FeedPost: Codable {
    let updatedAt, description, type: String?
    let users: FeedUsers?
    let postFiles: [PostImageModel]?

    enum CodingKeys: String, CodingKey {
        case updatedAt, description, type, users
        case postFiles = "post_files"
    }
}

// MARK: - User
struct FeedUsers: Codable {
    let id: Int?
    let name, profileImage, profileImageThumb: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case profileImage = "profile_image"
        case profileImageThumb = "profile_image_thumb"
    }
}


struct PostImageModel: Codable {
    let title, imageURL: String?
    let videoURL: String?

    enum CodingKeys: String, CodingKey {
        case title
        case imageURL = "image_url"
        case videoURL = "video_url"
    }
}
