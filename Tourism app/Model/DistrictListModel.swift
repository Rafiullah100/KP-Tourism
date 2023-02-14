//
//  DistrictListModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 2/14/23.
//

import Foundation



struct DistrictListModel : Codable {
    let districts : DistrictsList?

    enum CodingKeys: String, CodingKey {

        case districts = "districts"
    }

}


struct DistrictsList : Codable {
    let count : Int?
    let rows : [DistrictsListRow]?

    enum CodingKeys: String, CodingKey {

        case count = "count"
        case rows = "rows"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        rows = try values.decodeIfPresent([DistrictsListRow].self, forKey: .rows)
    }

}

struct DistrictsListRow : Codable {
    let id : Int?
    let user_id : Int?
    let title : String?
    let slug : String?
    let geographical_area : String?
    let thumbnail_image : String?
    let preview_image : String?
    let location_title : String?
    let latitude : String?
    let longitude : String?
    let mapbox_location_key : Int?
    let description : String?
    let is_featured : Bool?
    let is_top : Bool?
    let views_counter : Int?
    let status : Int?
    let isDeleted : Int?
    let createdAt : String?
    let updatedAt : String?
    let district_category_id : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case title = "title"
        case slug = "slug"
        case geographical_area = "geographical_area"
        case thumbnail_image = "thumbnail_image"
        case preview_image = "preview_image"
        case location_title = "location_title"
        case latitude = "latitude"
        case longitude = "longitude"
        case mapbox_location_key = "mapbox_location_key"
        case description = "description"
        case is_featured = "is_featured"
        case is_top = "is_top"
        case views_counter = "views_counter"
        case status = "status"
        case isDeleted = "isDeleted"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case district_category_id = "district_category_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        geographical_area = try values.decodeIfPresent(String.self, forKey: .geographical_area)
        thumbnail_image = try values.decodeIfPresent(String.self, forKey: .thumbnail_image)
        preview_image = try values.decodeIfPresent(String.self, forKey: .preview_image)
        location_title = try values.decodeIfPresent(String.self, forKey: .location_title)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        mapbox_location_key = try values.decodeIfPresent(Int.self, forKey: .mapbox_location_key)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        is_featured = try values.decodeIfPresent(Bool.self, forKey: .is_featured)
        is_top = try values.decodeIfPresent(Bool.self, forKey: .is_top)
        views_counter = try values.decodeIfPresent(Int.self, forKey: .views_counter)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        isDeleted = try values.decodeIfPresent(Int.self, forKey: .isDeleted)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        district_category_id = try values.decodeIfPresent(Int.self, forKey: .district_category_id)
    }

}
