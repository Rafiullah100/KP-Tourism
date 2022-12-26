//
//  PoiCategoriesModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/23/22.
//

import Foundation

// MARK: - Welcome
struct PoiCategoriesModel: Codable {
    let poicategories: [Poicategory]
}

// MARK: - Poicategory
struct Poicategory: Codable {
    let id: Int
    let title, slug, icon: String
    let status, isDeleted: Int
    let createdAt, updatedAt: String
}
