//
//  CommentsModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/24/23.
//

import Foundation

//struct CommentsModel: Codable {
//    let comments: Comments
//}
//
//// MARK: - Comments
//struct Comments: Codable {
//    let count: Int
//    let rows: [CommentsRows]
//}
//
//// MARK: - Row
//struct CommentsRows: Codable {
//    let createdAt, updatedAt: String
//    let id, blogID, userID: Int
//    let comment: String
//    let status, isDeleted: Int
//    let users: CommentUsers
//
//    enum CodingKeys: String, CodingKey {
//        case createdAt, updatedAt, id
//        case blogID = "blog_id"
//        case userID = "user_id"
//        case comment, status, isDeleted, users
//    }
//}
//
//// MARK: - Users
//struct CommentUsers: Codable {
//    let profileImage, name: String
//
//    enum CodingKeys: String, CodingKey {
//        case profileImage = "profile_image"
//        case name
//    }
//}

////////jkkjo

struct CommentsModel: Codable {
    let comments: Comments?
}

// MARK: - Comments
struct Comments: Codable {
    let count: Int?
    let rows: [CommentsRows]?
}

// MARK: - Row
struct CommentsRows: Codable {
    let createdAt, updatedAt: String?
    let id, blogID, userID: Int?
    let comment: String?
    let status, isDeleted: Int?
    let users: CommentUsers?
    let replies: [CommentsReply]?

    enum CodingKeys: String, CodingKey {
        case createdAt, updatedAt, id
        case blogID = "blog_id"
        case userID = "user_id"
        case comment, status, isDeleted, users, replies
    }
}

// MARK: - Reply
struct CommentsReply: Codable {
    let createdAt, updatedAt: String?
    let id, commentID, userID: Int?
    let reply: String?
    let status, isDeleted: Int?
    let users: CommentUsers?

    enum CodingKeys: String, CodingKey {
        case createdAt, updatedAt, id
        case commentID = "comment_id"
        case userID = "user_id"
        case reply, status, isDeleted, users
    }
}

// MARK: - Users
struct CommentUsers: Codable {
    let id: Int?
    let uuid, name, profileImage, profileImageThumb: String?

    enum CodingKeys: String, CodingKey {
        case id, uuid, name
        case profileImage = "profile_image"
        case profileImageThumb = "profile_image_thumb"
    }
}
