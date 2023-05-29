//
//  PackageSectionModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/30/23.
//

import Foundation


struct PackageSectionModel: Codable {
    let success: Bool
    let wishlist: [PackageWishlistModel]
}

// MARK: - Wishlist
struct PackageWishlistModel: Codable {
    let createdAt, updatedAt: String?
    let id, userID: Int?
    let districtID, attractionID, poiID, socialEventID: Int?
    let blogID, bookStayID, postPivotID: Int?
    let tourPackageID: Int?
    let itineraryID, localProductID: Int?
    let sourceType: String?
    let status, isDeleted: Int?
    let tourPackage: WishlistTourPackage

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
        case tourPackage = "tour_package"
    }
}

// MARK: - TourPackage
struct WishlistTourPackage: Codable {
    let startDate, endDate, isExpired, durationDays: String?
    let registration, discount: String?
    let id: Int?
    let uuid: String?
    let userID, fromDistrictID, toDistrictID: Int?
    let title, slug: String?
    let priceOld, price: Int?
    let priceType: String?
    let numberOfPeople, noOfAdults, children: Int?
    let childrenAge, transport, phoneNo, email: String?
    let groupTour, family, adults, wheelchair: Bool?
    let transportType, previewImage, thumbnailImage, tourPackageStartDate: String?
    let tourPackageEndDate, deadline, startTime, endTime: String?
    let description: String?
    let isFeatured: Bool?
    let approvedBy, viewsCounter, userInterest, likeCount: Int?
    let usersInterestCount, userLike, userWishlist: Int?
    let activities: [WishlistTourPackageActivity]

    enum CodingKeys: String, CodingKey {
        case startDate, endDate
        case isExpired = "is_expired"
        case durationDays = "duration_days"
        case registration, discount, id, uuid
        case userID = "user_id"
        case fromDistrictID = "from_district_id"
        case toDistrictID = "to_district_id"
        case title, slug
        case priceOld = "price_old"
        case price
        case priceType = "price_type"
        case numberOfPeople = "number_of_people"
        case noOfAdults = "no_of_adults"
        case children
        case childrenAge = "children_age"
        case transport
        case phoneNo = "phone_no"
        case email
        case groupTour = "group_tour"
        case family, adults, wheelchair
        case transportType = "transport_type"
        case previewImage = "preview_image"
        case thumbnailImage = "thumbnail_image"
        case tourPackageStartDate = "start_date"
        case tourPackageEndDate = "end_date"
        case deadline
        case startTime = "start_time"
        case endTime = "end_time"
        case description
        case isFeatured = "is_featured"
        case approvedBy = "approved_by"
        case viewsCounter = "views_counter"
        case userInterest = "user_interest"
        case likeCount = "like_count"
        case usersInterestCount = "users_interest_count"
        case userLike = "user_like"
        case userWishlist = "user_wishlist"
        case activities
    }
}

// MARK: - Activity
struct WishlistTourPackageActivity: Codable {
    let departureDate, departureTime: String?
    let id, tourPackageID, day: Int?
    let fromPlace, toPlace, activityDepartureDate, activityDepartureTime: String?
    let stayIn, description: String?
    let isDeleted: Int?
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case departureDate, departureTime, id
        case tourPackageID = "tour_package_id"
        case day
        case fromPlace = "from_place"
        case toPlace = "to_place"
        case activityDepartureDate = "departure_date"
        case activityDepartureTime = "departure_time"
        case stayIn = "stay_in"
        case description, isDeleted, createdAt, updatedAt
    }
}
