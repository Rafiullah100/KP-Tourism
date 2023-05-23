//
//  Struct + Extensions.swift
//  Tourism app
//
//  Created by Rafi on 19/11/2022.
//

import Foundation

enum ConnectionType {
    case follower
    case following
}

struct Sections {
    let title: String!
    let image: String!
    let selectedImage: String!
}

struct Coordinates {
    let lat: Double
    let long: Double
}

struct Destination: Codable {
    let image: String
    let title: String
}

struct VisitArea: Codable {
    let image: String
    let background: String
    let title: String
    let geoTypeID: String
}

struct Contacts {
    let photo: String?
    let department: String?
    let phone: String?
}

enum LocationCategory {
    case district
    case tourismSpot
}

enum DetailType {
    case event
    case adventure
}

enum UserType {
    case seller
    case tourist
    case user
}

enum MediaType: CaseIterable {
    case image
    case video
    case virtual
}

enum galleryType: CaseIterable {
    case gallery
    case poi
}
//this is struct


struct TourDetail {
    let area: String?
    let experience: String?
    let destination: String?
    let information: String?
    let accomodation: String?
}

enum PostType {
    case post
    case story
    case edit
}

enum ProfileSection: CaseIterable {
    case post
    case product
    case blog
}

enum Travel {
    case textual
    case navigation
}

enum ThemeMode: String {
    case dark = "dark"
    case light = "light"
}

enum TabName: String {
    case login = "Login"
    case profile = "Profile"
}

enum ProfileType: String {
    case user
    case otherUser
}

enum wishlistSection: String, CaseIterable {
    case post = "post"
    case attraction = "attraction"
    case district = "district"
//        case poi = "poi"
//        case event = "social_event"
//        case blog = "blog"
//        case book = "book_stay"
        case package = "tour_package"
//        case itinerary = "itinerary"
        case product = "local_product"
}

struct VisitPdf: Codable {
    let question: String?
    let title: String?
    let image: String?
}

struct CommentModel: Codable {
    let comment: String?
    let name: String?
    let image: String?
    let time: String
    let commentId: Int?
    
}

struct Checkbox {
    var id: Int
    var isChecked: Bool
}
