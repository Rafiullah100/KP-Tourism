//
//  ProfileModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 2/28/23.
//

import Foundation

struct ProfileModel: Codable {
    let userDetails: UserProfileDetails
}

// MARK: - UserDetail

struct UserProfileDetails: Codable {
    let name, uuid: String
    let about: String?
    let userType: String
    let isSeller: String?
    let profileImage, profileImageThumb: String
    let userFollowers, userFollowings, isFollowed, postsCount: Int

    enum CodingKeys: String, CodingKey {
        case name, uuid, about
        case userType = "user_type"
        case isSeller = "is_seller"
        case profileImage = "profile_image"
        case profileImageThumb = "profile_image_thumb"
        case userFollowers, userFollowings, isFollowed, postsCount
    }
}

//
//struct ProfileModel : Codable {
//    let userDetails : UserDetails?
//
//    enum CodingKeys: String, CodingKey {
//
//        case userDetails = "userDetails"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        userDetails = try values.decodeIfPresent(UserDetails.self, forKey: .userDetails)
//    }
//
//}
//
//
//struct UserDetails : Codable {
//    let name : String?
//    let profile_image : String?
//    let userFollowers : Int?
//    let userFollowings : Int?
//    let isFollowed : Int?
//    let postsCount : Int?
//    let id : Int?
//    let blogs : [ProfileBlogs]?
//    let local_products : [Profileproducts]?
//    let posts : [String]?
//    let user_following : [String]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case name = "name"
//        case profile_image = "profile_image"
//        case userFollowers = "userFollowers"
//        case userFollowings = "userFollowings"
//        case isFollowed = "isFollowed"
//        case postsCount = "postsCount"
//        case id = "id"
//        case blogs = "blogs"
//        case local_products = "local_products"
//        case posts = "posts"
//        case user_following = "user_following"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        profile_image = try values.decodeIfPresent(String.self, forKey: .profile_image)
//        userFollowers = try values.decodeIfPresent(Int.self, forKey: .userFollowers)
//        userFollowings = try values.decodeIfPresent(Int.self, forKey: .userFollowings)
//        isFollowed = try values.decodeIfPresent(Int.self, forKey: .isFollowed)
//        postsCount = try values.decodeIfPresent(Int.self, forKey: .postsCount)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        blogs = try values.decodeIfPresent([ProfileBlogs].self, forKey: .blogs)
//        local_products = try values.decodeIfPresent([Profileproducts].self, forKey: .local_products)
//        posts = try values.decodeIfPresent([String].self, forKey: .posts)
//        user_following = try values.decodeIfPresent([String].self, forKey: .user_following)
//    }
//
//}
//
//
//struct Profileproducts : Codable {
//    let createdAt : String?
//    let id : Int?
//    let uuid : String?
//    let user_id : Int?
//    let district_id : Int?
//    let title : String?
//    let slug : String?
//    let price : Int?
//    let preview_image : String?
//    let thumbnail_image : String?
//    let description : String?
//    let status : String?
//    let is_featured : Bool?
//    let approved_by : String?
//    let views_counter : Int?
//    let isDeleted : Int?
//    let updatedAt : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case createdAt = "createdAt"
//        case id = "id"
//        case uuid = "uuid"
//        case user_id = "user_id"
//        case district_id = "district_id"
//        case title = "title"
//        case slug = "slug"
//        case price = "price"
//        case preview_image = "preview_image"
//        case thumbnail_image = "thumbnail_image"
//        case description = "description"
//        case status = "status"
//        case is_featured = "is_featured"
//        case approved_by = "approved_by"
//        case views_counter = "views_counter"
//        case isDeleted = "isDeleted"
//        case updatedAt = "updatedAt"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
//        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
//        district_id = try values.decodeIfPresent(Int.self, forKey: .district_id)
//        title = try values.decodeIfPresent(String.self, forKey: .title)
//        slug = try values.decodeIfPresent(String.self, forKey: .slug)
//        price = try values.decodeIfPresent(Int.self, forKey: .price)
//        preview_image = try values.decodeIfPresent(String.self, forKey: .preview_image)
//        thumbnail_image = try values.decodeIfPresent(String.self, forKey: .thumbnail_image)
//        description = try values.decodeIfPresent(String.self, forKey: .description)
//        status = try values.decodeIfPresent(String.self, forKey: .status)
//        is_featured = try values.decodeIfPresent(Bool.self, forKey: .is_featured)
//        approved_by = try values.decodeIfPresent(String.self, forKey: .approved_by)
//        views_counter = try values.decodeIfPresent(Int.self, forKey: .views_counter)
//        isDeleted = try values.decodeIfPresent(Int.self, forKey: .isDeleted)
//        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
//    }
//
//}
//
//
//struct ProfileBlogs : Codable {
//    let createdAt : String?
//    let id : Int?
//    let uuid : String?
//    let user_id : Int?
//    let district_id : Int?
//    let attraction_id : Int?
//    let poi_id : Int?
//    let title : String?
//    let slug : String?
//    let preview_image : String?
//    let thumbnail_image : String?
//    let description : String?
//    let status : String?
//    let is_featured : Bool?
//    let approved_by : String?
//    let views_counter : Int?
//    let isDeleted : Int?
//    let updatedAt : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case createdAt = "createdAt"
//        case id = "id"
//        case uuid = "uuid"
//        case user_id = "user_id"
//        case district_id = "district_id"
//        case attraction_id = "attraction_id"
//        case poi_id = "poi_id"
//        case title = "title"
//        case slug = "slug"
//        case preview_image = "preview_image"
//        case thumbnail_image = "thumbnail_image"
//        case description = "description"
//        case status = "status"
//        case is_featured = "is_featured"
//        case approved_by = "approved_by"
//        case views_counter = "views_counter"
//        case isDeleted = "isDeleted"
//        case updatedAt = "updatedAt"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
//        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
//        district_id = try values.decodeIfPresent(Int.self, forKey: .district_id)
//        attraction_id = try values.decodeIfPresent(Int.self, forKey: .attraction_id)
//        poi_id = try values.decodeIfPresent(Int.self, forKey: .poi_id)
//        title = try values.decodeIfPresent(String.self, forKey: .title)
//        slug = try values.decodeIfPresent(String.self, forKey: .slug)
//        preview_image = try values.decodeIfPresent(String.self, forKey: .preview_image)
//        thumbnail_image = try values.decodeIfPresent(String.self, forKey: .thumbnail_image)
//        description = try values.decodeIfPresent(String.self, forKey: .description)
//        status = try values.decodeIfPresent(String.self, forKey: .status)
//        is_featured = try values.decodeIfPresent(Bool.self, forKey: .is_featured)
//        approved_by = try values.decodeIfPresent(String.self, forKey: .approved_by)
//        views_counter = try values.decodeIfPresent(Int.self, forKey: .views_counter)
//        isDeleted = try values.decodeIfPresent(Int.self, forKey: .isDeleted)
//        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
//    }
//
//}
