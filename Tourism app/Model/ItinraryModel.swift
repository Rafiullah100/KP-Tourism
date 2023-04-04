//
//  ItinraryModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/6/23.
//

import Foundation

struct ItinraryModel: Codable {
    let itineraries: Itineraries
}

struct Itineraries: Codable {
    let count: Int
    let rows: [ItinraryRow]
}

struct ItinraryRow: Codable {
    let displayDate: String
    let id: Int
    let uuid: String
    let userID, fromDistrictID, toDistrictID: Int
    let title, slug, thumbnailImage, previewImage: String
    let family, adults, wheelchair: Bool
    let transportType, transport, description, status: String
    let isFeatured: Bool
    let approvedBy, viewsCounter, isDeleted: Int
    let createdAt, updatedAt: String
    let userLike, isWished: Int
    let fromDistricts: ItinraryDistricts
    let activities: [ItinraryActivity]
    let toDistricts: ItinraryDistricts
//    let comments, likes: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case displayDate, id, uuid
        case userID = "user_id"
        case fromDistrictID = "from_district_id"
        case toDistrictID = "to_district_id"
        case title, slug
        case thumbnailImage = "thumbnail_image"
        case previewImage = "preview_image"
        case family, adults, wheelchair
        case transportType = "transport_type"
        case transport, description, status
        case isFeatured = "is_featured"
        case approvedBy = "approved_by"
        case viewsCounter = "views_counter"
        case isDeleted, createdAt, updatedAt, userLike, isWished
        case fromDistricts = "from_districts"
        case activities
        case toDistricts = "to_districts"
//        case comments, likes
    }
}

// MARK: - Activity

struct ItinraryActivity: Codable {
    let departureDate, departureTime: String
    let id, itineraryID, day: Int
    let fromPlace, toPlace, activityDepartureDate, activityDepartureTime: String
    let stayIn, description: String
    let isDeleted: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case departureDate, departureTime, id
        case itineraryID = "itinerary_id"
        case day
        case fromPlace = "from_place"
        case toPlace = "to_place"
        case activityDepartureDate = "departure_date"
        case activityDepartureTime = "departure_time"
        case stayIn = "stay_in"
        case description, isDeleted, createdAt, updatedAt
    }
}


// MARK: - Districts

struct ItinraryDistricts: Codable {
    let id: Int
    let title, slug: String
}
