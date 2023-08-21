//
//  TourListModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 8/15/23.
//

import Foundation

struct TourListModel: Codable {
    let success: Bool?
    let userTourPlans: [UserTourPlanModel]?
    let message: String?
}

// MARK: - UserTourPlan
struct UserTourPlanModel: Codable {
    let id, userID: Int?
    let geoType: String?
    let districtID, attractionID, bookStayID: Int?
    let travelerInfo, description: String?
    let fileURL: String?
    let createdAt, updatedAt: String?
    let attraction: TourListAttraction?
    let district, bookStay: TourListBookStay?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case geoType = "geo_type"
        case districtID = "district_id"
        case attractionID = "attraction_id"
        case bookStayID = "book_stay_id"
        case travelerInfo = "traveler_info"
        case description
        case fileURL = "file_url"
        case createdAt, updatedAt, attraction, district
        case bookStay = "book_stay"
    }
}

// MARK: - Attraction
struct TourListAttraction: Codable {
    let title, latitude, longitude, displayImage: String?
    let attractionCategoryPivots: [TourListAttractionCategoryPivot]?
    let pois: [TourListPois]?

    enum CodingKeys: String, CodingKey {
        case title, latitude, longitude
        case displayImage = "display_image"
        case attractionCategoryPivots = "attraction_category_pivots"
        case pois
    }
}

// MARK: - AttractionCategoryPivot
struct TourListAttractionCategoryPivot: Codable {
    let attractionID: Int?
    let attractionCategories: TourListAttractionCategories?

    enum CodingKeys: String, CodingKey {
        case attractionID = "attraction_id"
        case attractionCategories = "attraction_categories"
    }
}

// MARK: - AttractionCategories
struct TourListAttractionCategories: Codable {
    let id: Int?
    let title, icon: String?
}

// MARK: - Pois
struct TourListPois: Codable {
    let id: Int?
    let title, slug, contactNo: String?
    let districtID, attractionID, poiCategoryID: Int?
    let family, adults: Bool?
    let locationTitle, latitude, longitude, description: String?
    let displayImage: String?
    let authorID: Int?
    let status: Bool?
    let viewsCounter, isDeleted: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, slug
        case contactNo = "contact_no"
        case districtID = "district_id"
        case attractionID = "attraction_id"
        case poiCategoryID = "poi_category_id"
        case family, adults
        case locationTitle = "location_title"
        case latitude, longitude, description
        case displayImage = "display_image"
        case authorID = "author_id"
        case status
        case viewsCounter = "views_counter"
        case isDeleted, createdAt, updatedAt
    }
}

// MARK: - BookStay
struct TourListBookStay: Codable {
    let title, latitude, longitude, thumbnailImage: String?
    let pois: [TourListPois]?

    enum CodingKeys: String, CodingKey {
        case title, latitude, longitude
        case thumbnailImage = "thumbnail_image"
        case pois
    }
}
