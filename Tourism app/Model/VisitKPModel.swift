//
//  VisitKPModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 2/9/23.
//

import Foundation

struct VisitKPModel: Codable {
    let attractions: VisitKPAttractions
}

// MARK: - Attractions
struct VisitKPAttractions: Codable {
    let count: Int
    let rows: [VisitKPRow]
}

// MARK: - Row
struct VisitKPRow: Codable {
    let id: Int
    let title, slug, description, previewImage: String
    let thumbnailImage: String
    let isWizard: Bool

    enum CodingKeys: String, CodingKey {
        case id, title, slug, description
        case previewImage = "preview_image"
        case thumbnailImage = "thumbnail_image"
        case isWizard = "is_wizard"
    }
}


///
///
///
//experience model
struct DistrictCatModel: Codable {
    let districtCategorories: [DistrictCategorory]

    enum CodingKeys: String, CodingKey {
        case districtCategorories = "district_categorories"
    }
}

// MARK: - DistrictCategorory
struct DistrictCategorory: Codable {
    let id: Int
    let title, icon, createdAt: String
}
