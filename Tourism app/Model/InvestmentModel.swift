//
//  InvestmentModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/7/23.
//

import Foundation

struct InvestmentModel: Codable {
    let investments: Investments?
}

// MARK: - Investments
struct Investments: Codable {
    let count: Int?
    let rows: [InvestmentRow]?
}

// MARK: - Row
struct InvestmentRow: Codable {
    let id: Int?
    let title, slug, fileURL, imageURL: String?
    let sort, viewsCounter: Int?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, slug
        case fileURL = "fileUrl"
        case imageURL = "imageUrl"
        case sort
        case viewsCounter = "views_counter"
        case updatedAt
    }
}
