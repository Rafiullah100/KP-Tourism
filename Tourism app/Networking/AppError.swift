//
//  AppError.swift
//  Yummie
//
//  Created by Emmanuel Okwara on 30/04/2021.
//

import Foundation

enum AppError: LocalizedError, Equatable {
    case errorDecoding
    case unknownError
    case invalidUrl
    case serverError
    case noInternet
    
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Something went wrong. Please try again later."
        case .unknownError:
            return "Something went wrong. Please try again later."
        case .invalidUrl:
            return "Invalid URL"
        case .serverError:
            return "Something went wrong. Please try again later."
        case .noInternet:
            return "You're currently offline. Please connect with Wifi and try again later."
        }
    }
}
