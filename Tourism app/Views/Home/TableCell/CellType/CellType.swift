//
//  CellType.swift
//  Tourism app
//
//  Created by Rafi on 17/11/2022.
//

import Foundation
import UIKit


enum CellType{
    
    case explore
    case attraction
    case adventure
    case south
    case tour
    case product
    case arch
    case blog
    case event

    func getHeight() -> CGFloat{
        switch self {
        case .explore, .attraction, .adventure, .south : return 300
        case .tour, .product, .arch: return 350
        case .event, .blog: return 400
        
        }
    }
    
    func getClass() -> UITableViewCell.Type{
        switch self {
        case .explore: return ExploreTableViewCell.self
        case .attraction: return AttractionTableViewCell.self
        case .adventure: return AdventureTableViewCell.self
        case .south: return SouthTableViewCell.self
        case .tour: return TourTableViewCell.self
        case .product:
            return ProductTableViewCell.self
        case .arch:
            return ArchTableViewCell.self
        case .blog:
            return BlogTableViewCell.self
        case .event:
            return EventTableViewCell.self
        }
    }
    
}
