//
//  SuggestedUserModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 5/14/23.
//

import Foundation

struct SuggestedUserModel: Codable {
    let success: Bool?
    let suggestedUsers: [SuggestedUser]
    let suggestedUsersCount: Int?
    let message: String?
}

// MARK: - SuggestedUser
struct SuggestedUser: Codable {
    let id: Int?
    let name, profileImage, profileImageThumb, uuid: String?
    let country: String?
    let city: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case profileImage = "profile_image"
        case profileImageThumb = "profile_image_thumb"
        case uuid, country, city
    }
}
