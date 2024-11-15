//
//  AlertModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 2/3/23.
//

import Foundation

struct AlertModel: Codable {
    let warnings: [Warning]
}

// MARK: - Warning
struct Warning: Codable {
    let id, userID, categoryID, districtID: Int
    let attractionID: Int
    let title, slug, locationTitle, latitude: String
    let longitude, description, previewImage, thumbnailImage: String
    let type: String
    let status, isDeleted: Int
    let createdAt, updatedAt: String
    let warningCategories: WarningCategories

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case categoryID = "category_id"
        case districtID = "district_id"
        case attractionID = "attraction_id"
        case title, slug
        case locationTitle = "location_title"
        case latitude, longitude, description
        case previewImage = "preview_image"
        case thumbnailImage = "thumbnail_image"
        case type, status, isDeleted, createdAt, updatedAt
        case warningCategories = "warning_categories"
    }
}

// MARK: - WarningCategories
struct WarningCategories: Codable {
    let id: Int
    let title, slug: String
}
