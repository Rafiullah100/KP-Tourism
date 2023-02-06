//
//  AccomodationModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 2/6/23.
//

import Foundation

struct AccomodationModel: Codable {
    let accomodations: [Accomodation]
}

// MARK: - Accomodation
struct Accomodation: Codable {
    let id, districtID, attractionID, userID: Int
    let title, slug, locationTitle, latitude: String
    let longitude, previewImage, thumbnailImage, description: String
    let noRoom: Int
    let parking, covidSafe, family, adults: Bool
    let createdAt: String
    let commentCount, likeCount: Int
    let priceFrom: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case districtID = "district_id"
        case attractionID = "attraction_id"
        case userID = "user_id"
        case title, slug
        case locationTitle = "location_title"
        case latitude, longitude
        case previewImage = "preview_image"
        case thumbnailImage = "thumbnail_image"
        case description
        case noRoom = "no_room"
        case parking
        case covidSafe = "covid_safe"
        case family, adults, createdAt
        case commentCount = "comment_count"
        case likeCount = "like_count"
        case priceFrom = "price_from"
    }
}
