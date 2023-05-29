//
//  ProductSectionModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 4/10/23.
//

import Foundation
//


struct ProductSectionModel: Codable {
    let success: Bool
    let wishlist: [ProductWishlistModel]
}

// MARK: - Wishlist
struct ProductWishlistModel: Codable {
    let createdAt, updatedAt: String?
    let id, userID: Int?
    let districtID, attractionID, poiID, socialEventID: Int?
    let blogID, bookStayID, postPivotID, tourPackageID: Int?
    let itineraryID: Int?
    let localProductID: Int?
    let sourceType: String?
    let status, isDeleted: Int?
    let localProduct: WishlistLocalProduct

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
        case status, isDeleted
        case localProduct = "local_product"
    }
}

// MARK: - LocalProduct
struct WishlistLocalProduct: Codable {
    let createdAt: String?
    let id: Int?
    let uuid: String?
    let userID, districtID: Int?
    let title, slug: String?
    let price: Int?
    let previewImage, thumbnailImage, description: String?
    let isFeatured: Bool?
    let approvedBy: Int?
    let viewsCounter: Int?
    let updatedAt: String?
    let userLike, isWished: Int?
    let districts: ProductWishlistDistricts
    let users: ProductWishlistUsers
    let likes: [ProductWishlistLike]

    enum CodingKeys: String, CodingKey {
        case createdAt, id, uuid
        case userID = "user_id"
        case districtID = "district_id"
        case title, slug, price
        case previewImage = "preview_image"
        case thumbnailImage = "thumbnail_image"
        case description
        case isFeatured = "is_featured"
        case approvedBy = "approved_by"
        case viewsCounter = "views_counter"
        case updatedAt, userLike, isWished, districts, users, likes
    }
}

// MARK: - Districts
struct ProductWishlistDistricts: Codable {
    let id: Int?
    let title, slug: String?
}

// MARK: - Like
struct ProductWishlistLike: Codable {
    let likesCount: Int?
}

// MARK: - Users
struct ProductWishlistUsers: Codable {
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
