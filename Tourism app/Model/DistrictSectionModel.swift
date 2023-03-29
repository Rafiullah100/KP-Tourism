//
//  DistrictSectionModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/29/23.
//

import Foundation

struct DistrictSectionModel: Codable {
    let success: Bool
    let wishlist: [DistrictWishlistModel]
}

// MARK: - Wishlist
struct DistrictWishlistModel: Codable {
    let createdAt, updatedAt: String?
    let id, userID, districtID: Int?
    let attractionID, poiID, socialEventID, blogID: Int?
    let bookStayID, postPivotID, tourPackageID, itineraryID: Int?
    let localProductID: Int?
    let sourceType: String?
    let status, isDeleted: Int?
    let district: WishlistDistrict?

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
        case status, isDeleted, district
    }
}

// MARK: - District
struct WishlistDistrict: Codable {
    let id, userID: Int?
    let title, slug, geographicalArea, thumbnailImage: String?
    let previewImage, locationTitle, latitude, longitude: String?
    let mapboxLocationKey: Int?
    let description: String?
    let isFeatured, isTop: Bool?
    let viewsCounter, status, isDeleted: Int?
    let createdAt, updatedAt: String?
    let districtCategoryID: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title, slug
        case geographicalArea = "geographical_area"
        case thumbnailImage = "thumbnail_image"
        case previewImage = "preview_image"
        case locationTitle = "location_title"
        case latitude, longitude
        case mapboxLocationKey = "mapbox_location_key"
        case description
        case isFeatured = "is_featured"
        case isTop = "is_top"
        case viewsCounter = "views_counter"
        case status, isDeleted, createdAt, updatedAt
        case districtCategoryID = "district_category_id"
    }
}
