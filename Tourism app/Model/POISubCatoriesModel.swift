//
//  POISubCatoriesModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/26/22.
//

import Foundation

import Foundation

// MARK: - Welcome
struct POISubCatoriesModel: Codable {
    let pois: Pois
}

// MARK: - Pois
struct Pois: Codable {
    let count: Int?
    let rows: [POISubCatoryModel]
}

// MARK: - Row
struct POISubCatoryModel: Codable {
    let id: Int?
    let title, slug: String?
    let districtID, poiCategoryID: Int?
    let family, adults: Bool?
    let locationTitle, lat, long, rowDescription: String?
    let displayImage: String?
    let authorID: Int?
    let status: Bool?
    let viewsCounter, isDeleted: Int?
    let createdAt, updatedAt: String?
    let poiCategories: PoiCategories

    enum CodingKeys: String, CodingKey {
        case id, title, slug
        case districtID = "district_id"
        case poiCategoryID = "poi_category_id"
        case family, adults
        case locationTitle = "location_title"
        case lat, long
        case rowDescription = "description"
        case displayImage = "display_image"
        case authorID = "author_id"
        case status
        case viewsCounter = "views_counter"
        case isDeleted, createdAt, updatedAt
        case poiCategories = "poi_categories"
    }
}

// MARK: - PoiCategories
struct PoiCategories: Codable {
    let id: Int?
    let title, slug, icon: String?
    let status, isDeleted: Int?
    let createdAt, updatedAt: String?
}

