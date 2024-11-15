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


//struct NewsFeedModel: Codable {
//    let count: Int?
//    let feeds: [FeedModel]?
//}

struct NewsFeedModel : Codable {
    let count : Int?
    let feeds : [FeedModel]?

    enum CodingKeys: String, CodingKey {

        case count = "count"
        case feeds = "feeds"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        feeds = try values.decodeIfPresent([FeedModel].self, forKey: .feeds)
    }

}

struct FeedModel : Codable {
    let createdAt : String?
    let updatedAt : String?
    let id : Int?
    let post_id : Int?
    let action : String?
    let user_id : Int?
    let commentsCount : Int?
    let likesCount : Int?
    let isLiked : Int?
    let isWished : Int?
    let post : FeedPost?
    let user : FeedUser?

    enum CodingKeys: String, CodingKey {

        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case id = "id"
        case post_id = "post_id"
        case action = "action"
        case user_id = "user_id"
        case commentsCount = "commentsCount"
        case likesCount = "likesCount"
        case isLiked = "isLiked"
        case isWished = "isWished"
        case post = "post"
        case user = "user"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        post_id = try values.decodeIfPresent(Int.self, forKey: .post_id)
        action = try values.decodeIfPresent(String.self, forKey: .action)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        commentsCount = try values.decodeIfPresent(Int.self, forKey: .commentsCount)
        likesCount = try values.decodeIfPresent(Int.self, forKey: .likesCount)
        isLiked = try values.decodeIfPresent(Int.self, forKey: .isLiked)
        isWished = try values.decodeIfPresent(Int.self, forKey: .isWished)
        post = try values.decodeIfPresent(FeedPost.self, forKey: .post)
        user = try values.decodeIfPresent(FeedUser.self, forKey: .user)
    }

}

// MARK: - Post
//struct FeedPost: Codable {
//    let updatedAt, description, type: String?
//    let users: FeedUsers?
//    let postFiles: [PostImageModel]?
//
//    enum CodingKeys: String, CodingKey {
//        case updatedAt, description, type, users
//        case postFiles = "post_files"
//    }
//}

struct FeedPost : Codable {
    let updatedAt : String?
    let description : String?
    let type : String?
    let post_files : [PostImageModel]?
    let users : FeedUsers?

    enum CodingKeys: String, CodingKey {

        case updatedAt = "updatedAt"
        case description = "description"
        case type = "type"
        case post_files = "post_files"
        case users = "users"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        post_files = try values.decodeIfPresent([PostImageModel].self, forKey: .post_files)
        users = try values.decodeIfPresent(FeedUsers.self, forKey: .users)
    }

}

// MARK: - User
//struct FeedUsers: Codable {
//    let id: Int?
//    let name, profileImage, profileImageThumb: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case profileImage = "profile_image"
//        case profileImageThumb = "profile_image_thumb"
//    }
//}

struct FeedUsers : Codable {
    let id : Int?
    let name : String?
    let profile_image : String?
    let isSeller, isTourist: String?
    
    let profile_image_thumb : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case profile_image = "profile_image"
        case isSeller = "is_seller"
        case isTourist = "is_tourist"
        case profile_image_thumb = "profile_image_thumb"
    }
}


//struct PostImageModel: Codable {
//    let title, imageURL: String?
//    let videoURL: String?
//
//    enum CodingKeys: String, CodingKey {
//        case title
//        case imageURL = "image_url"
//        case videoURL = "video_url"
//    }
//}

struct PostImageModel : Codable {
    let title : String?
    let image_url : String?
    let video_url : String?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case image_url = "image_url"
        case video_url = "video_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
        video_url = try values.decodeIfPresent(String.self, forKey: .video_url)
    }

}

struct FeedUser : Codable {
    let id : Int?
    let name : String?
    let profile_image : String?
    let profile_image_thumb : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case profile_image = "profile_image"
        case profile_image_thumb = "profile_image_thumb"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        profile_image = try values.decodeIfPresent(String.self, forKey: .profile_image)
        profile_image_thumb = try values.decodeIfPresent(String.self, forKey: .profile_image_thumb)
    }

}
