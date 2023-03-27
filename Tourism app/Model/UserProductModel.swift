//
//  UserProductModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/17/23.
//

import Foundation

struct UserProductModel: Codable {
    let localProducts: UserLocalProducts?

    enum CodingKeys: String, CodingKey {
        case localProducts = "local_products"
    }
}

// MARK: - LocalProducts
struct UserLocalProducts: Codable {
    let count: Int?
    let rows: [UserProductRow]?
}

// MARK: - Row
struct UserProductRow: Codable {
    let createdAt: String?
    let id: Int?
    let uuid: String?
    let userID, districtID: Int?
    let title, slug: String?
    let price: Int?
    let previewImage, thumbnailImage, description: String?
    let isFeatured: Bool?
    let approvedBy: String?
    let viewsCounter: Int?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case createdAt, id, uuid
        case userID = "user_id"
        case districtID = "district_id"
        case title, slug, price
        case previewImage = "preview_image"
        case thumbnailImage = "thumbnail_image"
        case description
        case isFeatured = "is_featured"
        case approvedBy = "approved_by"
        case viewsCounter = "views_counter"
        case updatedAt
    }
}
