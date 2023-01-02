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
