//
//  AdventureModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/29/22.
//

import Foundation

struct AdventureModel: Codable {
    let adventures: [Adventure]
}

// MARK: - Adventure
struct Adventure: Codable {
    let id: Int
    let uuid: String
    let districtID: Int
//    let approvedBy: String?
    let userID: Int
    let title, locationTitle, latitude, longitude: String
    let startDate, endDate, contactInfo, previewImage: String
    let thumbnailImage, adventureDescription, type, status: String
    let isDeleted: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, uuid
        case districtID = "district_id"
//        case approvedBy = "approved_by"
        case userID = "user_id"
        case title
        case locationTitle = "location_title"
        case latitude, longitude
        case startDate = "start_date"
        case endDate = "end_date"
        case contactInfo = "contact_info"
        case previewImage = "preview_image"
        case thumbnailImage = "thumbnail_image"
        case adventureDescription = "description"
        case type, status, isDeleted, createdAt, updatedAt
    }
}
