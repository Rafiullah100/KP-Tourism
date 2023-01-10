//
//  AttractionModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/28/22.
//

import Foundation


struct AttractionModel: Codable {
    let attractions: HomeAttractions
}

struct HomeAttractions: Codable {
    let count: Int
    let rows: [AttractionsDistrict]
}


struct AttractionsDistrict: Codable {
    let id: Int
    let title, slug: String
    let districtID: Int
    let isTopAttraction, family, adults: Bool
    let locationTitle: String
    let latitude, longitude: String?
    let description, displayImage, previewImage: String
    let authorID: Int
    let parentID: Int?
    let type: String
    let status, viewsCounter, isDeleted: Int
    let createdAt, updatedAt: String
    let attractionGalleries: [AttractionGallery]

    enum CodingKeys: String, CodingKey {
        case id, title, slug
        case districtID = "district_id"
        case isTopAttraction = "is_top_attraction"
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
        case attractionGalleries = "attraction_galleries"
    }
}

struct AttractionGallery: Codable {
    let id, attractionID, subAttractionID: Int
    let type, title: String
    let imageURL, videoURL: String?
    let virtualURL: String?
    let status, isDeleted: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case attractionID = "attraction_id"
        case subAttractionID = "sub_attraction_id"
        case type, title
        case imageURL = "image_url"
        case videoURL = "video_url"
        case virtualURL = "virtual_url"
        case status, isDeleted, createdAt, updatedAt
    }
}


