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
            return "Response could not be decoded"
        case .unknownError:
            return "Bruhhh!!! I have no idea what go on"
        case .invalidUrl:
            return "Invalid URL"
        case .serverError:
            return "Something went wrong."
        case .noInternet:
            return "You're currently offline. Please connect with Wifi and try again later."
        }
    }
}
