//
//  ProductModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/4/23.
//

import Foundation


// MARK: - Welcome
struct ProductModel: Codable {
    let localProducts: [LocalProduct]
    let count: Int
    enum CodingKeys: String, CodingKey {
        case count
        case localProducts = "local_products"
    }
}

// MARK: - LocalProduct
struct LocalProduct: Codable {
    let id: Int
    let uuid: String
    let userID, districtID: Int
    let title: String
    let price: Int
    let previewImage, thumbnailImage, localProductDescription: String
    let isFeatured: Bool
    let approvedBy: String?
    let viewsCounter: Int
    let districts: ProductDistricts
    let users: ProductUsers
    let comments: [ProductComment]
    let likes: [ProductLike]
    let createdAt: String?
    let userLike: Int?

    enum CodingKeys: String, CodingKey {
        case id, uuid
        case userID = "user_id"
        case districtID = "district_id"
        case title, price
        case previewImage = "preview_image"
        case thumbnailImage = "thumbnail_image"
        case localProductDescription = "description"
        case isFeatured = "is_featured"
        case approvedBy = "approved_by"
        case viewsCounter = "views_counter"
        case districts, users, comments, likes
        case createdAt = "createdAt"
        case userLike
    }
}

// MARK: - Comment
struct ProductComment: Codable {
    let commentsCount: Int
}

// MARK: - Districts
struct ProductDistricts: Codable {
    let id: Int
    let title, slug: String
}

// MARK: - Like
struct ProductLike: Codable {
    let likesCount: Int
}

// MARK: - Users
struct ProductUsers: Codable {
    let id: Int
    let name: String
    let mobileNo: String?
    let profileImage: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case mobileNo = "mobile_no"
        case profileImage = "profile_image"
    }
}
