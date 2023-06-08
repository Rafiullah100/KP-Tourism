//
//  AccomodationModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 2/6/23.
//

import Foundation

struct AccomodationModel: Codable {
    let count: Int
    let accomodations: [Accomodation]
}

// MARK: - Accomodation
struct Accomodation: Codable {
    let id, districtID, attractionID, userID: Int?
    let title, slug, locationTitle, latitude: String?
    let longitude: String?
    let contactNo: String?
    let previewImage, thumbnailImage, description: String?
    let noRoom: Int?
    let parking, covidSafe, family, adults: Bool?
    let type: String?
    let viewsCounter: Int?
    let createdAt: String?
    let commentCount, likeCount, priceFrom, userLike: Int?
    let isWished: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case districtID = "district_id"
        case attractionID = "attraction_id"
        case userID = "user_id"
        case title, slug
        case locationTitle = "location_title"
        case latitude, longitude
        case contactNo = "contact_no"
        case previewImage = "preview_image"
        case thumbnailImage = "thumbnail_image"
        case description
        case noRoom = "no_room"
        case parking
        case covidSafe = "covid_safe"
        case family, adults, type
        case viewsCounter = "views_counter"
        case createdAt
        case commentCount = "comment_count"
        case likeCount = "like_count"
        case priceFrom = "price_from"
        case userLike, isWished
    }
}
