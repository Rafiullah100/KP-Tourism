//
//  OTPModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 4/19/23.
//

import Foundation

struct OTPModel: Codable {
    let success: Bool?
    let user: OTPUser?
    let message: String?
}

// MARK: - User
struct OTPUser: Codable {
    let id: Int?
    let uuid, username, profileImage, userType: String?

    enum CodingKeys: String, CodingKey {
        case id, uuid, username
        case profileImage = "profile_image"
        case userType = "user_type"
    }
}
