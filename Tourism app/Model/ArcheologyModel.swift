//
//  ArcheologyModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/5/23.
//

import Foundation

struct ArcheologyModel: Codable {
    let archeology: [Archeology]
}

// MARK: - Archeology
struct Archeology: Codable {
    let id: Int
    let imageURL: String?
    let virtualURL: String
    let attractions: ArcheologyAttractions

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "image_url"
        case virtualURL = "virtual_url"
        case attractions
    }
}

// MARK: - Attractions
struct ArcheologyAttractions: Codable {
    let id: Int
    let title, slug: String
    let districts: ArcheologyDistricts
}

// MARK: - Districts
struct ArcheologyDistricts: Codable {
    let title: String
}


//struct ArcheologyModel : Codable {
//    let archeology : [Archeology]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case archeology = "archeology"
//    }
//
//
//}
//
//// MARK: - Archeology
//
//struct Archeology : Codable {
//    let title : String?
//    let id : Int?
//    let districts : ArcheologyDistricts?
//    let archeologyAttractions : [ArcheologyAttractions]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case title = "title"
//        case id = "id"
//        case districts = "districts"
//        case archeologyAttractions = "attraction_virtual_tours"
//    }
//
//}
//
//
//
//struct ArcheologyAttractions : Codable {
//    let id : Int?
//    let attraction_id : Int?
//    let sub_attraction_id : Int?
//    let type : String?
//    let title : String?
//    let image_url : String?
//    let video_url : String?
//    let virtual_url : String?
//    let status : Int?
//    let isDeleted : Int?
//    let createdAt : String?
//    let updatedAt : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case attraction_id = "attraction_id"
//        case sub_attraction_id = "sub_attraction_id"
//        case type = "type"
//        case title = "title"
//        case image_url = "image_url"
//        case video_url = "video_url"
//        case virtual_url = "virtual_url"
//        case status = "status"
//        case isDeleted = "isDeleted"
//        case createdAt = "createdAt"
//        case updatedAt = "updatedAt"
//    }
//
//
//}
//
//struct ArcheologyDistricts : Codable {
//    let title : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case title = "title"
//    }
//
//}
