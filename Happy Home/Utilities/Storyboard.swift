//
//  Storyboard.swift
//  News Hunt
//
//  Created by MacBook Pro on 8/1/23.
//
import UIKit

enum Storyboard: String {
    case auth = "Auth"
    case tabs = "Tabs"
    case home = "Home"
    case order = "Order"
    case profile = "Profile"
    case product = "Products"

    func instantiate<T>(identifier: T.Type) -> T {
        let storyboard = UIStoryboard(name: rawValue, bundle: nil)
        guard let viewcontroller = storyboard.instantiateViewController(withIdentifier: String(describing: identifier)) as? T else {
            fatalError("No such view controller found")
        }
        return viewcontroller
    }
}

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0

        for attribute in attributes {
            // Only apply to cells, not to supplementary views (like headers/footers)
            if attribute.representedElementCategory == .cell {
                // If this is a new row, reset the left margin
                if attribute.frame.origin.y >= maxY {
                    leftMargin = sectionInset.left
                }
                
                // Align the cell to the left margin
                attribute.frame.origin.x = leftMargin
                
                // Update the left margin for the next cell in the row
                leftMargin += attribute.frame.width + minimumInteritemSpacing
                
                // Update maxY to the bottom edge of the current row
                maxY = max(attribute.frame.maxY, maxY)
            }
        }
        
        return attributes
    }
}
