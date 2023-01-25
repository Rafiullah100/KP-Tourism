//
//  BlogsModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/29/22.
//

import Foundation

import Foundation

// MARK: - Welcome
struct BlogsModel: Codable {
    let blog: [Blog]
}

// MARK: - Blog
struct Blog: Codable {
    let id: Int
    let uuid: String
    let userID, districtID, attractionID: Int
    let poiID: Int?
    let title, slug, previewImage, thumbnailImage: String
    let blogDescription: String
    let isFeatured: Int
    let approvedBy: String?
    let viewsCounter: Int
    let users: BlogUsers
    let districts, attractions, pois: BlogAttractions
    let comments: BlogComments
    let likes: BlogLikes

    enum CodingKeys: String, CodingKey {
        case id, uuid
        case userID = "user_id"
        case districtID = "district_id"
        case attractionID = "attraction_id"
        case poiID = "poi_id"
        case title, slug
        case previewImage = "preview_image"
        case thumbnailImage = "thumbnail_image"
        case blogDescription = "description"
        case isFeatured = "is_featured"
        case approvedBy = "approved_by"
        case viewsCounter = "views_counter"
        case users, districts, attractions, pois, comments, likes
    }
}

// MARK: - Attractions
struct BlogAttractions: Codable {
    let id: Int?
    let title: String?
    let slug: String?
}

// MARK: - Comments
struct BlogComments: Codable {
    let commentsCount: Int
}

// MARK: - Likes
struct BlogLikes: Codable {
    let likesCount: Int
}

// MARK: - Users
struct BlogUsers: Codable {
    let id: Int
    let name: String
    let mobileNo: String?
    let profileImage: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case mobileNo = "mobile_no"
        case profileImage = "profile_image"
    }
}

/////////////// fetch comment

struct CommentsModel : Codable {
    let comments : Comments?
    enum CodingKeys: String, CodingKey {
        case comments = "comments"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        comments = try values.decodeIfPresent(Comments.self, forKey: .comments)
    }
}

struct Comments : Codable {
    let count : Int?
    let rows : [CommentsRows]?

    enum CodingKeys: String, CodingKey {

        case count = "count"
        case rows = "rows"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        rows = try values.decodeIfPresent([CommentsRows].self, forKey: .rows)
    }

}

struct CommentsRows : Codable {
    let id : Int?
    let blog_id : Int?
    let user_id : Int?
    let comment : String?
    let status : Int?
    let isDeleted : Int?
    let createdAt : String?
    let updatedAt : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case blog_id = "blog_id"
        case user_id = "user_id"
        case comment = "comment"
        case status = "status"
        case isDeleted = "isDeleted"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        blog_id = try values.decodeIfPresent(Int.self, forKey: .blog_id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        isDeleted = try values.decodeIfPresent(Int.self, forKey: .isDeleted)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }

}
