//
//  EventSectionModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 7/3/23.
//

import Foundation

struct EventSectionModel: Codable {
    let success: Bool?
    let wishlist: [EventWishlistModel]?
}

// MARK: - Wishlist
struct EventWishlistModel: Codable {
    let createdAt, updatedAt: String?
    let id, userID: Int?
    let districtID, attractionID, poiID: Int?
    let socialEventID: Int?
    let blogID, bookStayID, postPivotID, tourPackageID: Int?
    let itineraryID, localProductID: Int?
    let sourceType: String?
    let status, isDeleted: Int?
    let socialEvent: WishlistSocialEvent?

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
        case socialEvent = "social_event"
    }
}

// MARK: - SocialEvent
struct WishlistSocialEvent: Codable {
    let createdAt, startDate, endDate, isExpired: String?
    let durationDays: String?
    let id: Int?
    let uuid: String?
    let districtID: Int?
    let approvedBy: String?
    let userID: Int?
    let title, locationTitle, latitude, longitude: String?
    let socialEventStartDate, socialEventEndDate, contactInfo, previewImage: String?
    let thumbnailImage, description, type: String?
    let viewsCounter: Int?
    let status: String?
    let isDeleted: Int?
    let updatedAt: String?
    let userInterest, likeCount, usersInterestCount, userLike: Int?
    let userWishlist: Int?

    enum CodingKeys: String, CodingKey {
        case createdAt, startDate, endDate
        case isExpired = "is_expired"
        case durationDays = "duration_days"
        case id, uuid
        case districtID = "district_id"
        case approvedBy = "approved_by"
        case userID = "user_id"
        case title
        case locationTitle = "location_title"
        case latitude, longitude
        case socialEventStartDate = "start_date"
        case socialEventEndDate = "end_date"
        case contactInfo = "contact_info"
        case previewImage = "preview_image"
        case thumbnailImage = "thumbnail_image"
        case description, type
        case viewsCounter = "views_counter"
        case status, isDeleted, updatedAt
        case userInterest = "user_interest"
        case likeCount = "like_count"
        case usersInterestCount = "users_interest_count"
        case userLike = "user_like"
        case userWishlist = "user_wishlist"
    }
}
