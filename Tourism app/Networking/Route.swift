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
    case fetchComment
    case registration
    case login
    case doComment
    case fetchAlerts
    case fetchAccomodation
    case fetchGettingHere
    case fetchVisitKp
    case weatherApi
    case likeApi
    case districtCategoriesApi
    case districtListApi
    case fetchFeeds
    case postApi
    case fetchProfile
    case fetchInvestment
    case deletePost
    case editPost
    case createStory

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
        case .fetchComment:
          return "api/mobile/likes_comments/get_comments"
        case .registration:
            return "api/mobile/auth/register"
        case .login:
            return "api/mobile/auth/login"
        case .doComment:
            return "api/mobile/blogs/do_comment"
        case .fetchAlerts:
           return "api/mobile/notifications/list"
        case .fetchAccomodation:
            return "api/mobile/attractions/accomodations"
        case .fetchGettingHere:
            return "api/mobile/districts/gettinghere"
        case .fetchVisitKp:
            return "api/mobile/visitkp/list"
        case .weatherApi:
            return "http://dataservice.accuweather.com//forecasts/v1/daily/5day/\(UserDefaults.standard.districtKey ?? 1771429)?apikey=Nx8fVetx3yB9xfvSAql3kICyQFTU1hHK"
        case .likeApi:
            return "api/mobile/likes_comments/do_like"
        case .districtCategoriesApi:
            return "api/mobile/districts/getcategories"
        case .districtListApi:
            return "api/mobile/districts/list"
        case .fetchFeeds:
            return "api/mobile/users/feeds"
        case .postApi:
            return "api/mobile/users/create_post?images&description"
        case .fetchProfile:
            return "api/mobile/users/profile"
        case .fetchInvestment:
            return "api/mobile/investments/list"
        case .deletePost:
            return "api/mobile/users/delete_post"
        case .editPost:
            return "api/mobile/users/edit_post"
        case .createStory:
            return "api/mobile/users/create_story"
        }
    }
}
