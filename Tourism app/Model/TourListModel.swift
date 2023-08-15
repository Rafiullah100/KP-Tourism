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
    let title: String?
    let attractionCategoryPivots: [AttractionCategoryPivot]?

    enum CodingKeys: String, CodingKey {
        case title
        case attractionCategoryPivots = "attraction_category_pivots"
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

// MARK: - BookStay
struct TourListBookStay: Codable {
    let title: String?
}
