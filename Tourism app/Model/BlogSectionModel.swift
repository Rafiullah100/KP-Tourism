//
//  BlogSectionModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 7/3/23.
//

import Foundation

struct BlogSectionModel: Codable {
    let success: Bool?
    let wishlist: [BlogWishlistModel]?
}

// MARK: - Wishlist
struct BlogWishlistModel: Codable {
    let createdAt, updatedAt: String?
    let id, userID: Int?
    let districtID, attractionID, poiID, socialEventID: Int?
    let blogID: Int?
    let bookStayID, postPivotID, tourPackageID, itineraryID: Int?
    let localProductID: Int?
    let sourceType: String?
    let status, isDeleted: Int?
    let blog: WishlistBlog?

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
        case status, isDeleted, blog
    }
}

// MARK: - Blog
struct WishlistBlog: Codable {
    let createdAt: String?
    let id: Int?
    let uuid: String?
    let userID, districtID, attractionID, poiID: Int?
    let title, slug, previewImage, thumbnailImage: String?
    let description: String?
    let isFeatured: Bool?
    let approvedBy: String?
    let viewsCounter: Int?
    let updatedAt: String?
    let userLike, likesCount, isWished: Int?
    let districts: WishlistBlogDistricts?
    let users: WishlistBlogUsers?

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
        case updatedAt, userLike, likesCount, isWished, districts, users
    }
}

// MARK: - Districts
struct WishlistBlogDistricts: Codable {
    let id: Int?
    let title, slug: String?
}

// MARK: - Users
struct WishlistBlogUsers: Codable {
    let id: Int?
    let name, uuid, mobileNo, profileImageThumb: String?
    let profileImage: String?

    enum CodingKeys: String, CodingKey {
        case id, name, uuid
        case mobileNo = "mobile_no"
        case profileImageThumb = "profile_image_thumb"
        case profileImage = "profile_image"
    }
}
