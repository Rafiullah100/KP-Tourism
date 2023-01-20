//
//  EventsModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/29/22.
//

import Foundation

struct EventsModel: Codable {
    let events: [EventListModel]
}

// MARK: - Event
struct EventListModel: Codable {
    let id: Int?
    let uuid: String?
    let districtID: Int?
    let approvedBy: String?
    let userID: Int?
    let title, locationTitle, latitude, longitude: String?
    let startDate, endDate, contactInfo, previewImage: String?
    let thumbnailImage, eventDescription, type, status: String?
    let isDeleted: Int?
    let createdAt, updatedAt: String?
    let isExpired: String?
    let durationDays: String?
    let socialEventUsers: [SocialEventUser]?

    enum CodingKeys: String, CodingKey {
        case id, uuid
        case districtID = "district_id"
        case approvedBy = "approved_by"
        case userID = "user_id"
        case title
        case locationTitle = "location_title"
        case latitude, longitude
        case startDate = "start_date"
        case endDate = "end_date"
        case contactInfo = "contact_info"
        case previewImage = "preview_image"
        case thumbnailImage = "thumbnail_image"
        case eventDescription = "description"
        case type, status, isDeleted, createdAt, updatedAt
        case isExpired = "is_expired"
        case durationDays = "duration_days"
        case socialEventUsers = "social_event_users"
    }
}

struct SocialEventUser: Codable {
    let userCount: Int?
}
