//
//  ProfileUpdateModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/17/23.
//

import Foundation

struct ProfileUpdateModel: Codable {
    let data: ProfileUpdate
    let success: Bool
    let message: String
}

// MARK: - DataClass
struct ProfileUpdate: Codable {
    let userID: Int
    let uuID, username, email, name: String
    let about, mobileNo, profileImage, profileImageThumb: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case uuID = "uuId"
        case username, email, name, about
        case mobileNo = "mobile_no"
        case profileImage = "profile_image"
        case profileImageThumb = "profile_image_thumb"
    }
}
