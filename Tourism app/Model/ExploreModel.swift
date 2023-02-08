//
//  ExploreModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/21/22.
//

import Foundation

//struct ExploreModel: Codable {
//    let attractions: ExploreAttractions
//}
//
//struct ExploreAttractions: Codable {
//    let count: Int
//    let rows: [ExploreDistrict]
//}
//
//struct ExploreDistrict: Codable {
//    let id, userID: Int?
//    let title, slug, geographicalArea, thumbnailImage: String?
//    let previewImage, locationTitle, latitude, longitude: String?
//    let description: String?
//    let featured, isTopDestination: Bool?
//    let viewsCounter, status, isDeleted: Int?
//    let createdAt, updatedAt: String?
//    let districtCategoryID: Int?
//    let attractions: [ExploreSubAttration]
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case userID = "user_id"
//        case title, slug
//        case geographicalArea = "geographical_area"
//        case thumbnailImage = "thumbnail_image"
//        case previewImage = "preview_image"
//        case locationTitle = "location_title"
//        case latitude, longitude
//        case description = "description"
//        case featured
//        case isTopDestination = "is_top_destination"
//        case viewsCounter = "views_counter"
//        case status, isDeleted, createdAt, updatedAt
//        case districtCategoryID = "district_category_id"
//        case attractions
//    }
//}
//
//struct ExploreSubAttration: Codable {
//    let id: Int?
//    let title, slug: String?
//    let districtID: Int?
//    let isTopAttraction, family, adults: Bool?
//    let locationTitle, lat, long, attractionDescription: String?
//    let displayImage, previewImage: String?
//    let authorID: Int?
//    let parentID: Int?
//    let type: String?
//    let status, viewsCounter, isDeleted: Int?
//    let createdAt, updatedAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, title, slug
//        case districtID = "district_id"
//        case isTopAttraction = "is_top_attraction"
//        case family, adults
//        case locationTitle = "location_title"
//        case lat, long
//        case attractionDescription = "description"
//        case displayImage = "display_image"
//        case previewImage = "preview_image"
//        case authorID = "author_id"
//        case parentID = "parent_id"
//        case type, status
//        case viewsCounter = "views_counter"
//        case isDeleted, createdAt, updatedAt
//    }
//}


struct ExploreModel: Codable {
    let count: Int
    let attractions: [ExploreDistrict]
}

// MARK: - WelcomeAttraction
struct ExploreDistrict: Codable {
    let id, userID: Int
    let title, slug: String
//    let geographicalArea: GeographicalArea
    let thumbnailImage, previewImage, locationTitle, latitude: String
    let longitude, description: String
    let isFeatured, isTop: Bool
    let viewsCounter, status, isDeleted: Int
    let createdAt, updatedAt: String
    let districtCategoryID, userLike: Int
    let attractions: [ExploreSubAttration]

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title, slug
//        case geographicalArea = "geographical_area"
        case thumbnailImage = "thumbnail_image"
        case previewImage = "preview_image"
        case locationTitle = "location_title"
        case latitude, longitude, description
        case isFeatured = "is_featured"
        case isTop = "is_top"
        case viewsCounter = "views_counter"
        case status, isDeleted, createdAt, updatedAt
        case districtCategoryID = "district_category_id"
        case userLike, attractions
    }
}

// MARK: - AttractionAttraction
struct ExploreSubAttration: Codable {
    let id: Int
    let title, slug: String
    let districtID: Int
    let isFeatured, isTop, family, adults: Bool
    let locationTitle: String
    let latitude, longitude: String?
    let description, displayImage, previewImage: String
    let authorID: Int
    let parentID: Int?
    let type: String
    let status, viewsCounter, isDeleted: Int
    let createdAt, updatedAt: String

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
        case isDeleted, createdAt, updatedAt
    }
}
