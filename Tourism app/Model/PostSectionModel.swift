//
//  PostSection.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/29/23.
//

import Foundation


//********************\\

struct PostSectionModel: Codable {
    let success: Bool
    let wishlist: [PostWishlistModel]
}

// MARK: - Wishlist
struct PostWishlistModel: Codable {
    let createdAt, updatedAt: String?
    let id, userID: Int?
    let districtID, attractionID, poiID, socialEventID: Int?
    let blogID, bookStayID: Int?
    let postPivotID: Int?
    let tourPackageID, itineraryID, localProductID: Int?
    let sourceType: String?
    let status, isDeleted: Int?
    let post: PostWishlist

    enum CodingKeys: String, CodingKey {
        case createdAt, updatedAt, id
        case userID = "user_id"
        case districtID = "district_id"
        case attractionID = "attraction_id" 
        case poiID = "poi_id"
        case socialEventID = "social_event_id"
        case blogID = "blog_id"
        case bookStayID = "book_stay_id"
        case postPivotID = "post_pivot_id"
        case tourPackageID = "tour_package_id"
        case itineraryID = "itinerary_id"
        case localProductID = "local_product_id"
        case sourceType = "source_type"
        case status, isDeleted, post
    }
}

// MARK: - WishlistPost
struct PostWishlist: Codable {
    let createdAt, updatedAt: String?
    let id, userID, postID: Int?
    let description: String?
    let action: String?
    let status, isDeleted: Int?
    let post: post

    enum CodingKeys: String, CodingKey {
        case createdAt, updatedAt, id
        case userID = "user_id"
        case postID = "post_id"
        case description, action, status, isDeleted, post
    }
}

// MARK: - PostPost
struct post: Codable {
    let createdAt, updatedAt: String?
    let id, userID: Int?
    let description, type: String?
    let viewsCounter, status, isDeleted: Int?
    let postFiles: [WishlistPostFile]

    enum CodingKeys: String, CodingKey {
        case createdAt, updatedAt, id
        case userID = "user_id"
        case description, type
        case viewsCounter = "views_counter"
        case status, isDeleted
        case postFiles = "post_files"
    }
}

// MARK: - PostFile
struct WishlistPostFile: Codable {
    let id, postID: Int?
    let title, type, imageURL: String?
    let videoURL: String?
    let isDeleted: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case postID = "post_id"
        case title, type
        case imageURL = "image_url"
        case videoURL = "video_url"
        case isDeleted, createdAt, updatedAt
    }
}
