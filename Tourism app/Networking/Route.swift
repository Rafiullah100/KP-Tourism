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
    case fetchPoiSubCategories
    case attractionbyDistrict
    case fetchAllEvents
    case fetchAdventure
    case fetchBlogs
    case fetchTourPackage
    case fetchGallery
    case fetchProduct
    case fetchArcheology
    case fetchEventsByDistrict
    case fetchProductByDistrict
    case fetchItinraries
    case fetchGalleryByDistrict
    case fetchAttractionByDistrict

    var description: String {
        switch self {
        case .fetchAllDistricts:
            return "api/mobile/districts/list"
        case .fetchExpolreDistrict:
            return "api/mobile/attractions/getdistrictwise"
        case .fetchPoiCategories:
            return "api/mobile/poi/getcategories"
        case .fetchPoiSubCategories:
            return "api/mobile/poi/getbydistrict"
        case .attractionbyDistrict:
            return "api/mobile/attractions/list"
        case .fetchAllEvents:
            return "api/mobile/events/getevents"
        case .fetchAdventure:
            return "api/mobile/events/getadventures"
        case .fetchBlogs:
            return "api/mobile/blogs/list"
        case .fetchTourPackage:
            return "api/mobile/tour_packages/list"
        case .fetchGallery:
            return "api/mobile/attractions/gallery"
        case .fetchProduct:
            return "api/mobile/local_products/list"
        case .fetchArcheology:
            return "api/mobile/attractions/getarcheology"
        case .fetchEventsByDistrict:
            return "api/mobile/events/geteventsbydistrict"
        case .fetchProductByDistrict:
            return "api/mobile/local_products/getbydistrict"
        case .fetchItinraries:
            return "api/mobile/districts/getitinerary"
        case .fetchGalleryByDistrict:
            return "api/mobile/attractions/getbydistrict"
        case .fetchAttractionByDistrict:
            return "api/mobile/attractions/getbydistrict"
        }
    }
}
