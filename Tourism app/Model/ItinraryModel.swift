//
//  ItinraryModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/6/23.
//

import Foundation

// MARK: - Welcome
//struct ItinraryModel: Codable {
//    let itineraries: Itineraries
//}
//
//// MARK: - Itineraries
//struct Itineraries: Codable {
//    let count: Int
//    let rows: [ItinraryRow]
//}
//
//// MARK: - Row
//struct ItinraryRow: Codable {
//    let id: Int
//    let uuid: String
//    let userID, fromDistrictID, toDistrictID: Int
//    let title, slug, thumbnailImage, previewImage: String
//    let family, adults, wheelchair: Bool
//    let transportType, transport, startDate, endDate: String
//    let rowDescription: String
//    let packageIncludes, packageExcludes, nightDay: String?
//    let status: String
//    let isFeatured: Bool
//    let approvedBy: String?
//    let viewsCounter, isDeleted: Int
//    let createdAt, updatedAt: String
//    let fromDistricts, toDistricts: ItinraryDistricts
////    let comments, likes: [JSONAny]
//
//    enum CodingKeys: String, CodingKey {
//        case id, uuid
//        case userID = "user_id"
//        case fromDistrictID = "from_district_id"
//        case toDistrictID = "to_district_id"
//        case title, slug
//        case thumbnailImage = "thumbnail_image"
//        case previewImage = "preview_image"
//        case family, adults, wheelchair
//        case transportType = "transport_type"
//        case transport
//        case startDate = "start_date"
//        case endDate = "end_date"
//        case rowDescription = "description"
//        case packageIncludes = "package_includes"
//        case packageExcludes = "package_excludes"
//        case nightDay = "night_day"
//        case status
//        case isFeatured = "is_featured"
//        case approvedBy = "approved_by"
//        case viewsCounter = "views_counter"
//        case isDeleted, createdAt, updatedAt
//        case fromDistricts = "from_districts"
//        case toDistricts = "to_districts"
////        case comments, likes
//    }
//}
//
//// MARK: - Districts
//struct ItinraryDistricts: Codable {
//    let id: Int
//    let title, slug: String
//}

///////////
struct ItinraryModel: Codable {
    let itineraries: Itineraries
}

// MARK: - Itineraries
struct Itineraries: Codable {
    let count: Int
    let rows: [ItinraryRow]
}

// MARK: - Row
struct ItinraryRow: Codable {
    let id: Int
    let uuid: String
    let userID, fromDistrictID, toDistrictID: Int
    let title, slug, thumbnailImage, previewImage: String
    let family, adults, wheelchair: Bool
    let transportType, transport, description, status: String
    let isFeatured: Bool
    let approvedBy: String?
    let viewsCounter, isDeleted: Int
    let createdAt, updatedAt: String
    let fromDistricts: ItinraryDistricts
    let activities: [ItinraryActivity]
    let toDistricts: ItinraryDistricts
//    let comments, likes: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case id, uuid
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
        case isDeleted, createdAt, updatedAt
        case fromDistricts = "from_districts"
        case activities
        case toDistricts = "to_districts"
//        case comments, likes
    }
}

// MARK: - Activity
struct ItinraryActivity: Codable {
    let id, itineraryID, day: Int
    let fromPlace, toPlace, departureDate, departureTime: String
    let stayIn, description: String
    let isDeleted: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case itineraryID = "itinerary_id"
        case day
        case fromPlace = "from_place"
        case toPlace = "to_place"
        case departureDate = "departure_date"
        case departureTime = "departure_time"
        case stayIn = "stay_in"
        case description, isDeleted, createdAt, updatedAt
    }
}

// MARK: - Districts
struct ItinraryDistricts: Codable {
    let id: Int
    let title, slug: String
}
