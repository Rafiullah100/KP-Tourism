//
//  NotificationListModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 5/20/23.
//

import Foundation

struct NotificationListModel: Codable {
    let notifications: Notifications
}

// MARK: - Notifications
struct Notifications: Codable {
    let count: Int?
    let rows: [NotificationsRow]
}

// MARK: - Row
struct NotificationsRow: Codable {
    let createdAt: String?
    let id: Int?
    let userBy, userFor, sourceID, source: String?
    let action, title, description: String?
    let isRead: Bool?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case createdAt, id
        case userBy = "user_by"
        case userFor = "user_for"
        case sourceID = "source_id"
        case source, action, title, description
        case isRead = "is_read"
        case updatedAt
    }
}

