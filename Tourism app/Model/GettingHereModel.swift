//
//  GettingHereModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 2/6/23.
//

import Foundation

//struct GettingHereModel: Codable {
//    let gettingHeres: [GettingHere]
//
//    enum CodingKeys: String, CodingKey {
//        case gettingHeres = "getting_heres"
//    }
//}
//
//// MARK: - GettingHere
//struct GettingHere: Codable {
//    let id, districtID, attractionID: Int
//    let title: String
//    let slug: String?
//    let imageURL, description, createdAt: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case districtID = "district_id"
//        case attractionID = "attraction_id"
//        case title, slug
//        case imageURL = "imageUrl"
//        case description, createdAt
//    }
//}


struct GettingHereModel: Codable {
    let gettingHeres: [GettingHere]

    enum CodingKeys: String, CodingKey {
        case gettingHeres = "getting_heres"
    }
}

// MARK: - GettingHere
struct GettingHere: Codable {
    let id, districtID, attractionID: Int
    let title: String
    let slug: String?
    let imageURL, description, createdAt: String
    let districts: GettingHereDistricts

    enum CodingKeys: String, CodingKey {
        case id
        case districtID = "district_id"
        case attractionID = "attraction_id"
        case title, slug
        case imageURL = "imageUrl"
        case description, createdAt, districts
    }
}

// MARK: - Districts
struct GettingHereDistricts: Codable {
    let latitude, longitude: String
}
