//
//  UserTourPackageModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 5/25/23.
//

import Foundation

struct ProfileTourPackage : Codable {
    let success : Bool?
    let userTourPackages : [UserProfileTourPackages]?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case success = "success"
        case userTourPackages = "userTourPackages"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        userTourPackages = try values.decodeIfPresent([UserProfileTourPackages].self, forKey: .userTourPackages)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}

struct UserProfileTourPackages : Codable {
    let createdAt : String?
    let startDate : String?
    let endDate : String?
    let is_expired : String?
    let duration_days : String?
    let registration : String?
//    let discount : Int?
    let id : Int?
    let uuid : String?
    let user_id : Int?
    let from_district_id : Int?
    let to_district_id : Int?
    let title : String?
    let slug : String?
    let price_old : Int?
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
    let status : String?
    let is_featured : Bool?
    let approved_by : Int?
    let views_counter : Int?
    let comment_count : Int?
    let like_count : Int?
    let user_like : Int?
    let user_wishlist : Int?
    let users : ProfileTourPackageUsers?
    let from_districts : FromProfileTourPackagedistricts?
    let to_districts : ToProfileTourPackagedistricts?

    enum CodingKeys: String, CodingKey {

        case createdAt = "createdAt"
        case startDate = "startDate"
        case endDate = "endDate"
        case is_expired = "is_expired"
        case duration_days = "duration_days"
        case registration = "registration"
//        case discount = "discount"
        case id = "id"
        case uuid = "uuid"
        case user_id = "user_id"
        case from_district_id = "from_district_id"
        case to_district_id = "to_district_id"
        case title = "title"
        case slug = "slug"
        case price_old = "price_old"
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
        case status = "status"
        case is_featured = "is_featured"
        case approved_by = "approved_by"
        case views_counter = "views_counter"
        case comment_count = "comment_count"
        case like_count = "like_count"
        case user_like = "user_like"
        case user_wishlist = "user_wishlist"
        case users = "users"
        case from_districts = "from_districts"
        case to_districts = "to_districts"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        startDate = try values.decodeIfPresent(String.self, forKey: .startDate)
        endDate = try values.decodeIfPresent(String.self, forKey: .endDate)
        is_expired = try values.decodeIfPresent(String.self, forKey: .is_expired)
        duration_days = try values.decodeIfPresent(String.self, forKey: .duration_days)
        registration = try values.decodeIfPresent(String.self, forKey: .registration)
//        discount = try values.decodeIfPresent(Int.self, forKey: .discount)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        from_district_id = try values.decodeIfPresent(Int.self, forKey: .from_district_id)
        to_district_id = try values.decodeIfPresent(Int.self, forKey: .to_district_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        price_old = try values.decodeIfPresent(Int.self, forKey: .price_old)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        price_type = try values.decodeIfPresent(String.self, forKey: .price_type)
        number_of_people = try values.decodeIfPresent(Int.self, forKey: .number_of_people)
        no_of_adults = try values.decodeIfPresent(Int.self, forKey: .no_of_adults)
        children = try values.decodeIfPresent(Int.self, forKey: .children)
        children_age = try values.decodeIfPresent(String.self, forKey: .children_age)
        transport = try values.decodeIfPresent(String.self, forKey: .transport)
        phone_no = try values.decodeIfPresent(String.self, forKey: .phone_no)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        group_tour = try values.decodeIfPresent(Bool.self, forKey: .group_tour)
        family = try values.decodeIfPresent(Bool.self, forKey: .family)
        adults = try values.decodeIfPresent(Bool.self, forKey: .adults)
        wheelchair = try values.decodeIfPresent(Bool.self, forKey: .wheelchair)
        transport_type = try values.decodeIfPresent(String.self, forKey: .transport_type)
        preview_image = try values.decodeIfPresent(String.self, forKey: .preview_image)
        thumbnail_image = try values.decodeIfPresent(String.self, forKey: .thumbnail_image)
        start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
        end_date = try values.decodeIfPresent(String.self, forKey: .end_date)
        deadline = try values.decodeIfPresent(String.self, forKey: .deadline)
        start_time = try values.decodeIfPresent(String.self, forKey: .start_time)
        end_time = try values.decodeIfPresent(String.self, forKey: .end_time)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        is_featured = try values.decodeIfPresent(Bool.self, forKey: .is_featured)
        approved_by = try values.decodeIfPresent(Int.self, forKey: .approved_by)
        views_counter = try values.decodeIfPresent(Int.self, forKey: .views_counter)
        comment_count = try values.decodeIfPresent(Int.self, forKey: .comment_count)
        like_count = try values.decodeIfPresent(Int.self, forKey: .like_count)
        user_like = try values.decodeIfPresent(Int.self, forKey: .user_like)
        user_wishlist = try values.decodeIfPresent(Int.self, forKey: .user_wishlist)
        users = try values.decodeIfPresent(ProfileTourPackageUsers.self, forKey: .users)
        from_districts = try values.decodeIfPresent(FromProfileTourPackagedistricts.self, forKey: .from_districts)
        to_districts = try values.decodeIfPresent(ToProfileTourPackagedistricts.self, forKey: .to_districts)
    }

}


struct FromProfileTourPackagedistricts : Codable {
    let id : Int?
    let title : String?
    let slug : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case slug = "slug"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
    }

}

struct ToProfileTourPackagedistricts : Codable {
    let id : Int?
    let title : String?
    let slug : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case slug = "slug"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
    }

}


struct ProfileTourPackageUsers : Codable {
    let id : Int?
    let name : String?
    let mobile_no : String?
    let profile_image : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case mobile_no = "mobile_no"
        case profile_image = "profile_image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        mobile_no = try values.decodeIfPresent(String.self, forKey: .mobile_no)
        profile_image = try values.decodeIfPresent(String.self, forKey: .profile_image)
    }

}
