//
//  AttractionModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/28/22.
//

import Foundation

// MARK: - Welcome
struct AttractionByDistrictModel: Codable {
    let attractions: AttractionsModel
}

// MARK: - Attractions
struct AttractionsModel: Codable {
    let count: Int
    let rows: [AttractionDistrictModel]
}

// MARK: - Row
struct AttractionDistrictModel: Codable {
    let id: Int?
    let title, slug: String?
    let districtID: Int?
    let isTopAttraction, family, adults: Bool?
    let locationTitle, lat, long, rowDescription: String?
    let displayImage, previewImage: String?
    let authorID: Int?
//    let parentID: JSONNull?
    let type: String?
    let status, viewsCounter, isDeleted: Int?
    let createdAt, updatedAt: String?
    let attractionGalleries: [AttractionGallery]

    enum CodingKeys: String, CodingKey {
        case id, title, slug
        case districtID = "district_id"
        case isTopAttraction = "is_top_attraction"
        case family, adults
        case locationTitle = "location_title"
        case lat, long
        case rowDescription = "description"
        case displayImage = "display_image"
        case previewImage = "preview_image"
        case authorID = "author_id"
//        case parentID = "parent_id"
        case type, status
        case viewsCounter = "views_counter"
        case isDeleted, createdAt, updatedAt
        case attractionGalleries = "attraction_galleries"
    }
}

// MARK: - AttractionGallery
struct AttractionGallery: Codable {
    let id, attractionID, subAttractionID: Int?
    let type, title, imageURL: String?
//    let videoURL, virtualURL: JSONNull?
    let status, isDeleted: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case attractionID = "attraction_id"
        case subAttractionID = "sub_attraction_id"
        case type, title
        case imageURL = "image_url"
//        case videoURL = "video_url"
//        case virtualURL = "virtual_url"
        case status, isDeleted, createdAt, updatedAt
    }
}
