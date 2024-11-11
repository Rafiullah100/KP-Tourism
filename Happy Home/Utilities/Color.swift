//
//  Color.swift
//  News Hunt
//
//  Created by MacBook Pro on 8/1/23.
//

import Foundation
import UIKit
enum CustomColor {
    case tabColor
    case yellowColor
    case tabTextColor
    case categoryColor
    case canceledOrderBackgroundColor
    case canceledOrderTextColor
    case pendingOrderBackgroundColor
    case pendingOrderTextColor
    case deliveryOrderBackgroundColor
    case deliveryOrderTextColor
}

extension CustomColor {
    var color: UIColor {
        switch self {
        case .tabColor:
            return UIColor(hex: 0xF8F7FB, alpha: 1.0)
        case .yellowColor:
            return UIColor(hex: 0xF6D935, alpha: 1.0)
        case .tabTextColor:
            return UIColor(hex: 0x8891A5, alpha: 1.0)
        case .categoryColor:
            return UIColor(hex: 0x1E272E, alpha: 0.8)
        case .canceledOrderBackgroundColor:
            return UIColor(hex: 0xFF3C3C, alpha: 0.1)
        case .canceledOrderTextColor:
            return UIColor(hex: 0xFF3C3C, alpha: 1.0)
        case .pendingOrderBackgroundColor:
            return UIColor(hex: 0xA3A3A3, alpha: 0.1)
        case .pendingOrderTextColor:
            return UIColor(hex: 0xA3A3A3, alpha: 1.0)
        case .deliveryOrderBackgroundColor:
            return UIColor(hex: 0xFE8900, alpha: 0.1)
        case .deliveryOrderTextColor:
            return UIColor(hex: 0xFE8900, alpha: 1.0)
        }
    }
}
