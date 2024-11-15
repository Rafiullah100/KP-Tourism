//
//  FeedStoriesModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/16/23.
//

import Foundation

struct FeedStoriesModel: Codable {
    let stories: StoriesModel?
}

// MARK: - Stories
struct StoriesModel: Codable {
    let count: Int?
    let rows: [StoriesRow]?
}

// MARK: - Row
struct StoriesRow: Codable {
    let updatedAt, description, type: String?
    let id: Int?
    let users: StoriesUsers?
    let postFiles: [StoriesPostFile]?

    enum CodingKeys: String, CodingKey {
        case updatedAt, description, type, id, users
        case postFiles = "post_files"
    }
}

// MARK: - PostFile
struct StoriesPostFile: Codable {
    let title, imageURL: String?
    let videoURL: String?

    enum CodingKeys: String, CodingKey {
        case title
        case imageURL = "image_url"
        case videoURL = "video_url"
    }
}

// MARK: - Users
struct StoriesUsers: Codable {
    let id: Int?
    let name, profileImage, profileImageThumb: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case profileImage = "profile_image"
        case profileImageThumb = "profile_image_thumb"
    }
}




