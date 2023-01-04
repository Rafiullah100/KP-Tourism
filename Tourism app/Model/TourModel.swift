//
//  TourModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/3/23.
//

import Foundation

struct TourModel : Codable {
    let tour : [TourPackage]

    enum CodingKeys: String, CodingKey {

        case tour = "tour"
    }
}

struct TourPackage : Codable {
    let id : Int?
    let uuid : String?
    let user_id : Int?
    let from_district_id : Int?
    let to_district_id : Int?
    let title : String?
    let slug : String?
    let price : Int?
    let price_type : String?
    let number_of_people : Int?
    let no_of_adults : Int?
    let children : Int?
    let children_age : String?
    let transport : String?
    let phone_no : String?
    let email : String?
    let group_tour : Bool?
    let family : Bool?
    let adults : Bool?
    let wheelchair : Bool?
    let transport_type : String?
    let preview_image : String?
    let thumbnail_image : String?
    let start_date : String?
    let end_date : String?
    let deadline : String?
    let start_time : String?
    let end_time : String?
    let description : String?
    let is_featured : Bool?
    let approved_by : Int?
    let views_counter : Int?
    let from_districts : FromDistricts?
    let to_districts : ToDistricts?
    let comments : [TourPackageComment]?
    let likes : [TourPackageLikes]?
    let activities : [TourActivities]?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case uuid = "uuid"
        case user_id = "user_id"
        case from_district_id = "from_district_id"
        case to_district_id = "to_district_id"
        case title = "title"
        case slug = "slug"
        case price = "price"
        case price_type = "price_type"
        case number_of_people = "number_of_people"
        case no_of_adults = "no_of_adults"
        case children = "children"
        case children_age = "children_age"
        case transport = "transport"
        case phone_no = "phone_no"
        case email = "email"
        case group_tour = "group_tour"
        case family = "family"
        case adults = "adults"
        case wheelchair = "wheelchair"
        case transport_type = "transport_type"
        case preview_image = "preview_image"
        case thumbnail_image = "thumbnail_image"
        case start_date = "start_date"
        case end_date = "end_date"
        case deadline = "deadline"
        case start_time = "start_time"
        case end_time = "end_time"
        case description = "description"
        case is_featured = "is_featured"
        case approved_by = "approved_by"
        case views_counter = "views_counter"
        case from_districts = "from_districts"
        case to_districts = "to_districts"
        case comments = "comments"
        case likes = "likes"
        case activities = "activities"
    }
}

struct TourActivities : Codable {
    let id : Int?
    let tour_package_id : Int?
    let day : Int?
    let from_place : String?
    let to_place : String?
    let departure_date : String?
    let departure_time : String?
    let stay_in : String?
    let description : String?
    let isDeleted : Int?
    let createdAt : String?
    let updatedAt : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case tour_package_id = "tour_package_id"
        case day = "day"
        case from_place = "from_place"
        case to_place = "to_place"
        case departure_date = "departure_date"
        case departure_time = "departure_time"
        case stay_in = "stay_in"
        case description = "description"
        case isDeleted = "isDeleted"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }
}

struct FromDistricts : Codable {
    let id : Int?
    let title : String?
    let slug : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case slug = "slug"
    }
}

struct ToDistricts : Codable {
    let id : Int?
    let title : String?
    let slug : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case slug = "slug"
    }
}

struct TourPackageComment: Codable {
    let commentsCount: Int
}

// MARK: - Likes
struct TourPackageLikes: Codable {
    let likesCount: Int
}
