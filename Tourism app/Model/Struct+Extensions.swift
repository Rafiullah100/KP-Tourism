//
//  Struct + Extensions.swift
//  Tourism app
//
//  Created by Rafi on 19/11/2022.
//

import Foundation

struct Sections {
    let title: String!
    let image: String!
    let selectedImage: String!
}

struct Coordinates {
    let lat: Double
    let long: Double
}

struct Destination {
    let image: String
    let title: String
}

struct VisitArea {
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

