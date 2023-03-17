//
//  UserBlogModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/17/23.
//

import Foundation

struct UserBlogModel: Codable {
    let blogs: UserBlogs
}

// MARK: - Blogs
struct UserBlogs: Codable {
    let count: Int
    let rows: [UserBlogRow]
}

// MARK: - Row
struct UserBlogRow: Codable {
    let createdAt: String
    let id: Int
    let uuid: String
    let userID, districtID, attractionID, poiID: Int
    let title, slug, previewImage, thumbnailImage: String
    let description: String
    let isFeatured: Bool
    let approvedBy: String?
    let viewsCounter: Int
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case createdAt, id, uuid
        case userID = "user_id"
        case districtID = "district_id"
        case attractionID = "attraction_id"
        case poiID = "poi_id"
        case title, slug
        case previewImage = "preview_image"
        case thumbnailImage = "thumbnail_image"
        case description
        case isFeatured = "is_featured"
        case approvedBy = "approved_by"
        case viewsCounter = "views_counter"
        case updatedAt
    }
}


