//
//  POISubCatoriesModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/26/22.
//

import Foundation

struct POISubCatoriesModel: Codable {
    let pois: Pois
}

// MARK: - Pois
struct Pois: Codable {
    let count: Int
    let rows: [POISubCatoryModel]
}

// MARK: - Row
struct POISubCatoryModel: Codable {
    let id: Int
    let title, slug, contactNo: String
    let districtID, attractionID, poiCategoryID: Int
    let family, adults: Bool
    let locationTitle, latitude, longitude, description: String
    let displayImage: String
    let authorID: Int
    let status: Bool
    let viewsCounter, isDeleted: Int
    let createdAt, updatedAt: String
    let poiCategories: PoiCategories
    let poiGalleries: [PoiGallery]

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
        case poiCategories = "poi_categories"
        case poiGalleries = "poi_galleries"
    }
}

// MARK: - PoiCategories
struct PoiCategories: Codable {
    let id: Int
    let title, slug, icon: String
    let status, isDeleted: Int
    let createdAt, updatedAt: String
}

// MARK: - PoiGallery
struct PoiGallery: Codable {
    let id, poiID: Int
    let title, type, imageURL: String
    let videoURL, virtualURL: String?
    let isDeleted: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case poiID = "poi_id"
        case title, type
        case imageURL = "image_url"
        case videoURL = "video_url"
        case virtualURL = "virtual_url"
        case isDeleted, createdAt, updatedAt
    }
}
