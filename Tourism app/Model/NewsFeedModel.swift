//
//  NewsFeedModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/1/23.
//

import Foundation

//struct NewsFeedModel : Codable {
//    let stories : [FeedStories]?
//    let feeds : [FeedModel]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case stories = "stories"
//        case feeds = "feeds"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        stories = try values.decodeIfPresent([FeedStories].self, forKey: .stories)
//        feeds = try values.decodeIfPresent([FeedModel].self, forKey: .feeds)
//    }
//
//}
//
//struct FeedStories : Codable {
//    let description : String?
//    let type : String?
//    let updatedAt : String?
//    let commentsCount : Int?
//    let likesCount : Int?
//    let id : Int?
//    let users : FeedUsersModel?
//    let post_images : [PostImageModel]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case description = "description"
//        case type = "type"
//        case updatedAt = "updatedAt"
//        case commentsCount = "commentsCount"
//        case likesCount = "likesCount"
//        case id = "id"
//        case users = "users"
//        case post_images = "post_images"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        description = try values.decodeIfPresent(String.self, forKey: .description)
//        type = try values.decodeIfPresent(String.self, forKey: .type)
//        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
//        commentsCount = try values.decodeIfPresent(Int.self, forKey: .commentsCount)
//        likesCount = try values.decodeIfPresent(Int.self, forKey: .likesCount)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        users = try values.decodeIfPresent(FeedUsersModel.self, forKey: .users)
//        post_images = try values.decodeIfPresent([PostImageModel].self, forKey: .post_images)
//    }
//
//}
//
//
//// MARK: - Feed
//struct FeedModel : Codable {
//    let description : String?
//    let type : String?
//    let updatedAt : String?
//    let commentsCount : Int?
//    let likesCount : Int?
//    let id : Int?
//    let users : FeedUsersModel?
//    let post_images : [PostImageModel]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case description = "description"
//        case type = "type"
//        case updatedAt = "updatedAt"
//        case commentsCount = "commentsCount"
//        case likesCount = "likesCount"
//        case id = "id"
//        case users = "users"
//        case post_images = "post_images"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        description = try values.decodeIfPresent(String.self, forKey: .description)
//        type = try values.decodeIfPresent(String.self, forKey: .type)
//        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
//        commentsCount = try values.decodeIfPresent(Int.self, forKey: .commentsCount)
//        likesCount = try values.decodeIfPresent(Int.self, forKey: .likesCount)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        users = try values.decodeIfPresent(FeedUsersModel.self, forKey: .users)
//        post_images = try values.decodeIfPresent([PostImageModel].self, forKey: .post_images)
//    }
//
//}
//
//// MARK: - PostImage
//
//
//struct PostImageModel : Codable {
//    let image_url : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case image_url = "image_url"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
//    }
//
//}
//
//// MARK: - Users
//
//struct FeedUsersModel : Codable {
//    let id : Int?
//    let name : String?
//    let profile_image : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case name = "name"
//        case profile_image = "profile_image"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        profile_image = try values.decodeIfPresent(String.self, forKey: .profile_image)
//    }
//
//}

//****************************************
struct NewsFeedModel: Codable {
    let stories: [FeedStories]
    let feeds: [FeedModel]
}

// MARK: - Feed
struct FeedModel: Codable {
    let updatedAt, description, type: String
    let commentsCount, likesCount, id: Int
    let users: FeedUsersModel
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

// MARK: - FeedUsers
struct FeedUsers: Codable {
    let id: Int
    let name, profileImage: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case profileImage = "profile_image"
    }
}

// MARK: - Story
struct FeedStories: Codable {
    let updatedAt, description, type: String
    let commentsCount, likesCount, id: Int
    let users: FeedUsersModel
    let postFiles: [PostImageModel]

    enum CodingKeys: String, CodingKey {
        case updatedAt, description, type, commentsCount, likesCount, id, users
        case postFiles = "post_files"
    }
}

// MARK: - StoryUsers
struct FeedUsersModel: Codable {
    let id: Int?
    let name, profileImage: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profileImage = "profile_image"
    }
}
