//
//  DataManager.swift
//  Tourism app
//
//  Created by MacBook Pro on 6/27/23.
//

import Foundation

class DataManager {
    static let shared = DataManager()


    var productModelObject: LocalProduct?
    var eventModelObject: EventListModel?
    var packageModelObject: TourPackage?
    var blogModelObject: Blog?
    var itinraryModelObject: ItinraryRow?
    var accomodationModelObject: Accomodation?

    var isExploreDataAvailable: Bool?
    
    
    var isExploreDataLoaded: Bool?
    var isInvestmentDataLoaded: Bool?
    var isPackageDataLoaded: Bool?
    var isEventDataLoaded: Bool?
    var isProductDataLoaded: Bool?
    var isBlogDataLoaded: Bool?

    
    private init() {
        isExploreDataLoaded = false
        isInvestmentDataLoaded = false
        isPackageDataLoaded = false
        isEventDataLoaded = false
        isProductDataLoaded = false
        isBlogDataLoaded = false

        // Private initializer to enforce singleton pattern
    }
}
