//
//  CellType.swift
//  Tourism app
//
//  Created by Rafi on 17/11/2022.
//

import Foundation
import UIKit


enum CellType: CaseIterable{
    
    case explore
    case investment
    case attraction
    case adventure
    case south
    case tour
    case product
    case arch
    case blog
    case event
    case visitKP

    func getHeight() -> CGFloat{
        if UIDevice.current.userInterfaceIdiom == .phone {
            switch self {
            case .explore, .attraction, .adventure, .south, .investment : return 300
            case .tour, .product, .arch: return 350
            case .event, .blog: return 400
            case .visitKP: return 150.0
            }
        }
        else if UIDevice.current.userInterfaceIdiom == .pad{
            switch self {
            case .explore, .attraction, .adventure, .south, .investment : return 500
            case .tour, .product, .arch: return 520
            case .event, .blog: return 700
            case .visitKP: return 300.0
            }
        }
        return 0
    }
   
    func getClass() -> UITableViewCell.Type{
        switch self {
        case .explore:
            return ExploreTableViewCell.self
        case .attraction:
            return AttractionTableViewCell.self
        case .adventure:
            return AdventureTableViewCell.self
        case .south:
            return SouthTableViewCell.self
        case .tour:
            return TourTableViewCell.self
        case .product:
            return ProductTableViewCell.self
        case .arch:
            return ArchTableViewCell.self
        case .blog:
            return BlogTableViewCell.self
        case .event:
            return EventTableViewCell.self
        case .visitKP:
            return VisitKPTableViewCell.self
        case .investment:
            return InvestmentTableViewCell.self
        }
    }
    
}
