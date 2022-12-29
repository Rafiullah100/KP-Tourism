//
//  BlogsModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/29/22.
//

import Foundation

struct BlogsModel: Codable {
    let blog: [Blog]
}

struct Blog: Codable {
    let id: Int?
    let uuid: String?
    let userID, districtID, attractionID: Int?
    let poiID: Int?
    let title, slug, previewImage, thumbnailImage: String?
    let blogDescription, status: String?
    let isFeatured: Bool?
    let approvedBy: String?
    let viewsCounter, isDeleted: Int?
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, uuid
        case userID = "user_id"
        case districtID = "district_id"
        case attractionID = "attraction_id"
        case poiID = "poi_id"
        case title, slug
        case previewImage = "preview_image"
        case thumbnailImage = "thumbnail_image"
        case blogDescription = "description"
        case status
        case isFeatured = "is_featured"
        case approvedBy = "approved_by"
        case viewsCounter = "views_counter"
        case isDeleted, createdAt, updatedAt
    }
}
