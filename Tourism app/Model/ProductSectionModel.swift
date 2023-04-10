//
//  ProductSectionModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 4/10/23.
//

import Foundation

struct ProductSectionModel: Codable {
    let success: Bool
    let wishlist: [ProductWishlistModel]
}

// MARK: - Wishlist
struct ProductWishlistModel: Codable {
    let createdAt, updatedAt: String
    let id, userID: Int
    let districtID, attractionID, poiID, socialEventID: Int?
    let blogID, bookStayID, postPivotID, tourPackageID: Int?
    let itineraryID: Int?
    let localProductID: Int
    let sourceType: String
    let status, isDeleted: Int
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
    let createdAt: String
    let id: Int
    let uuid: String
    let userID, districtID: Int
    let title, slug: String
    let price: Int
    let previewImage, thumbnailImage, description, status: String
    let isFeatured: Bool
    let approvedBy: String?
    let viewsCounter, isDeleted: Int
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case createdAt, id, uuid
        case userID = "user_id"
        case districtID = "district_id"
        case title, slug, price
        case previewImage = "preview_image"
        case thumbnailImage = "thumbnail_image"
        case description, status
        case isFeatured = "is_featured"
        case approvedBy = "approved_by"
        case viewsCounter = "views_counter"
        case isDeleted, updatedAt
    }
}
