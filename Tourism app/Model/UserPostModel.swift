//
//  UserPostModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/17/23.
//

import Foundation

struct UserPostModel: Codable {
    let posts: PostsModel?
}

// MARK: - Posts
struct PostsModel: Codable {
    let count: Int?
    let rows: [UserPostRow]?
}

// MARK: - Row
struct UserPostRow: Codable {
    let updatedAt, description, type: String?
    let id: Int?
    let users: PostOwner?
    let postFiles: [UserPostFile]?

    enum CodingKeys: String, CodingKey {
        case updatedAt, description, type, id, users
        case postFiles = "post_files"
    }
}

// MARK: - PostFile
struct UserPostFile: Codable {
    let title, imageURL: String?
    let videoURL: String?

    enum CodingKeys: String, CodingKey {
        case title
        case imageURL = "image_url"
        case videoURL = "video_url"
    }
}

// MARK: - Users
struct PostOwner: Codable {
    let id: Int?
    let name, profileImage, profileImageThumb: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case profileImage = "profile_image"
        case profileImageThumb = "profile_image_thumb"
    }
}
