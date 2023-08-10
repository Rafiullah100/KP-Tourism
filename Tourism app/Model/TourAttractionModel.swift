//
//  TourAttractionModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 8/10/23.
//

import Foundation

struct TourAttractionModel: Codable {
    let attractions: TourAttractions?
}

// MARK: - Attractions
struct TourAttractions: Codable {
    let count: Int?
    let rows: [TourAttractionsRow]?
}

// MARK: - Row
struct TourAttractionsRow: Codable {
    let id: Int?
    let title, slug: String?
    let districtID: Int?
    let isFeatured, isTop, family, adults: Bool?
    let locationTitle: String?
//    let latitude, longitude: Float?
    let description, displayImage, previewImage: String?
    let authorID: Int?
//    let parentID: Int?
    let type: String?
    let status, viewsCounter: Int?
    let attractionCategoryPivots: [AttractionCategoryPivot]?

    enum CodingKeys: String, CodingKey {
        case id, title, slug
        case districtID = "district_id"
        case isFeatured = "is_featured"
        case isTop = "is_top"
        case family, adults
        case locationTitle = "location_title"
//        case latitude, longitude
        case description
        case displayImage = "display_image"
        case previewImage = "preview_image"
        case authorID = "author_id"
//        case parentID = "parent_id"
        case type, status
        case viewsCounter = "views_counter"
        case attractionCategoryPivots = "attraction_category_pivots"
    }
}

// MARK: - AttractionCategoryPivot
struct AttractionCategoryPivot: Codable {
    let id: Int?
    let attractionCategories: TourAttractionCategories?

    enum CodingKeys: String, CodingKey {
        case id
        case attractionCategories = "attraction_categories"
    }
}

// MARK: - AttractionCategories
struct TourAttractionCategories: Codable {
    let title: String?
}
