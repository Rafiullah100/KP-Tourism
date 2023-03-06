//
//  ArcheologyModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/5/23.
//

import Foundation

//struct ArcheologyModel: Codable {
//    let archeology: [Archeology]
//}
//
//// MARK: - Archeology
//struct Archeology: Codable {
//    let id: Int
//    let imageURL: String?
//    let virtualURL: String
//    let attractions: ArcheologyAttractions
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case imageURL = "image_url"
//        case virtualURL = "virtual_url"
//        case attractions
//    }
//}
//
//// MARK: - Attractions
//struct ArcheologyAttractions: Codable {
//    let id: Int
//    let title, slug: String
//    let districts: ArcheologyDistricts
//}
//
//// MARK: - Districts
//struct ArcheologyDistricts: Codable {
//    let title: String
//}

struct ArcheologyModel : Codable {
    let archeology : [Archeology]?

    enum CodingKeys: String, CodingKey {

        case archeology = "archeology"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        archeology = try values.decodeIfPresent([Archeology].self, forKey: .archeology)
    }

}

// MARK: - Archeology

struct Archeology : Codable {
    let id : Int?
    let image_url : String?
    let virtual_url : String?
    let video_url : String?
    let type : String?
    let attractions : ArcheologyAttractions?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case image_url = "image_url"
        case virtual_url = "virtual_url"
        case video_url = "video_url"
        case type = "type"
        case attractions = "attractions"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
        virtual_url = try values.decodeIfPresent(String.self, forKey: .virtual_url)
        video_url = try values.decodeIfPresent(String.self, forKey: .video_url)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        attractions = try values.decodeIfPresent(ArcheologyAttractions.self, forKey: .attractions)
    }

}


struct ArcheologyAttractions : Codable {
    let id : Int?
    let title : String?
    let slug : String?
    let description : String?
    let districts : ArcheologyDistricts?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case slug = "slug"
        case description = "description"
        case districts = "districts"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        districts = try values.decodeIfPresent(ArcheologyDistricts.self, forKey: .districts)
    }

}

struct ArcheologyDistricts : Codable {
    let title : String?

    enum CodingKeys: String, CodingKey {

        case title = "title"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }

}
