//
//  Route.swift
//  Yummie
//
//  Created by Emmanuel Okwara on 30/04/2021.
//

import Foundation

enum Route {
    static let baseUrl = "https://staging-admin.kptourism.com/"
    
    case fetchAllDistricts
    case fetchExpolreDistrict
    case fetchPoiCategories
    case fetchOrders
    
    var description: String {
        switch self {
        case .fetchAllDistricts:
            return "api/mobile/districts/list"
        case .fetchExpolreDistrict:
            return "api/mobile/attractions/getdistrictwise"
        case .fetchPoiCategories:
            return "api/mobile/poi/getcategories"
        case .fetchOrders:
            return "/orders"
        }
    }
}
