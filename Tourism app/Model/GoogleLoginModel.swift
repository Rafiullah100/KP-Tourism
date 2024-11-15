//
//  GoogleLoginModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/27/23.
//

import Foundation

struct GoogleLoginModel: Codable {
    let success: Bool
    let message, token: String
    let userID: Int
    let uuID, username, email: String
    let name, mobileNo: String?
    let profileImage, profileImageThumb: String
    let isActive: Bool
    let lastLogin: String
    let about: String?

    
    enum CodingKeys: String, CodingKey {
        case success, message, token
        case userID = "userId"
        case uuID = "uuId"
        case username, email, name
        case mobileNo = "mobile_no"
        case profileImage = "profile_image"
        case profileImageThumb = "profile_image_thumb"
        case isActive
        case lastLogin = "last_login"
        case about
    }
}

