//
//  ApiResponse.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/27/23.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable {
    let status: Int
    let message: String?
    let data: T?
    let error: String?
}
