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


struct Contacts {
    let photo: String?
    let department: String?
    let phone: String?
}


enum LocationCategory {
    case district
    case tourismSpot
}
//this is struct
