//
//  ArcheologyModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/5/23.
//

import Foundation


//////////////////////////////////////////////////////

struct ArcheologyModel: Codable {
    let count: Int?
    let archeology: [Archeology]
}

// MARK: - Archeology
struct Archeology: Codable {
    let attractionID: Int?
    let attractions: ArcheologyAttractions

    enum CodingKeys: String, CodingKey {
        case attractionID = "attraction_id"
        case attractions
    }
}

// MARK: - Attractions
struct ArcheologyAttractions: Codable {
    let id: Int?
    let title, slug: String?
    let districtID: Int?
    let isFeatured, isTop, family, adults: Bool?
    let locationTitle, latitude, longitude, description: String?
    let displayImage, previewImage: String?
    let authorID: Int?
    let parentID: Int?
    let type: String?
    let status, viewsCounter, isDeleted: Int?
    let createdAt, updatedAt: String?
    let userLike, isWished, likesCount, commentsCount: Int?
    let districts: Districts

    enum CodingKeys: String, CodingKey {
        case id, title, slug
        case districtID = "district_id"
        case isFeatured = "is_featured"
        case isTop = "is_top"
        case family, adults
        case locationTitle = "location_title"
        case latitude, longitude, description
        case displayImage = "display_image"
        case previewImage = "preview_image"
        case authorID = "author_id"
        case parentID = "parent_id"
        case type, status
        case viewsCounter = "views_counter"
        case isDeleted, createdAt, updatedAt, userLike, isWished
        case likesCount = "LikesCount"
        case commentsCount = "CommentsCount"
        case districts
    }
}

// MARK: - Districts
struct ArcheologyDistricts: Codable {
    let title: String?
}
