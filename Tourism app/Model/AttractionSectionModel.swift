//
//  AttractionSectionModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/29/23.
//

import Foundation

struct AttractionSectionModel: Codable {
    let success: Bool?
    let wishlist: [AttractionWishlistModel]?
}

// MARK: - Wishlist
struct AttractionWishlistModel: Codable {
    let createdAt, updatedAt: String?
    let id, userID: Int?
    let districtID: String?
    let attractionID: Int?
    let poiID, socialEventID, blogID, bookStayID: String?
    let postPivotID, tourPackageID, itineraryID, localProductID: String?
    let sourceType: String?
    let status, isDeleted: Int?
    let attraction: WishlistAttraction?

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
        case status, isDeleted, attraction
    }
}

// MARK: - Attraction
struct WishlistAttraction: Codable {
    let id: Int?
    let title, slug: String?
    let districtID: Int?
    let isFeatured, isTop, family, adults: Bool?
    let locationTitle: String?
    let latitude, longitude: String?
    let description, displayImage, previewImage: String?
    let authorID: Int?
    let parentID: Int?
    let type: String?
    let status, viewsCounter, isDeleted: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, slug
        case districtID = "district_id"
        case isFeatured = "is_featured"
        case isTop = "is_top"
        case family, adults
        case locationTitle = "location_title"
        case latitude, longitude, description
        case displayImage = "display_image"
        case previewImage = "preview_image"
        case authorID = "author_id"
        case parentID = "parent_id"
        case type, status
        case viewsCounter = "views_counter"
        case isDeleted, createdAt, updatedAt
    }
}
