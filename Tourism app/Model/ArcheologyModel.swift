//
//  ArcheologyModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/5/23.
//

import Foundation



struct ArcheologyModel: Codable {
    let archeology: [Archeology]
}

// MARK: - Archeology
struct Archeology: Codable {
    let id, attractionID, subAttractionID: Int
    let type, title: String
    let imageURL: String?
    let videoURL: String
    let virtualURL: String?
    let status, isDeleted: Int
    let createdAt, updatedAt: String
    let attractions: ArcheologyAttractions

    enum CodingKeys: String, CodingKey {
        case id
        case attractionID = "attraction_id"
        case subAttractionID = "sub_attraction_id"
        case type, title
        case imageURL = "image_url"
        case videoURL = "video_url"
        case virtualURL = "virtual_url"
        case status, isDeleted, createdAt, updatedAt, attractions
    }
}

// MARK: - Attractions
struct ArcheologyAttractions: Codable {
    let id: Int
    let title, slug: String
    let districtID: Int
    let isTopAttraction, family, adults: Bool
    let locationTitle: String
    let latitude, longitude: String?
    let attractionsDescription, displayImage, previewImage: String
    let authorID: Int
    let parentID: Int?
    let type: String
    let status, viewsCounter, isDeleted: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, title, slug
        case districtID = "district_id"
        case isTopAttraction = "is_top_attraction"
        case family, adults
        case locationTitle = "location_title"
        case latitude, longitude
        case attractionsDescription = "description"
        case displayImage = "display_image"
        case previewImage = "preview_image"
        case authorID = "author_id"
        case parentID = "parent_id"
        case type, status
        case viewsCounter = "views_counter"
        case isDeleted, createdAt, updatedAt
    }
}
