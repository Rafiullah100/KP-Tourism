//
//  Helper.swift
//  Tourism app
//
//  Created by Rafi on 20/10/2022.
//

import Foundation
import UIKit

class Helper{
    static let shared = Helper()
    
    public func slideShow(images: [String], scrollView: UIScrollView, container: UIView){
        for i in 0..<images.count {
            let offset = i == 0 ? 0 : (CGFloat(i) * container.bounds.width)
            let imgView = UIImageView(frame: CGRect(x: offset, y: 0, width: container.bounds.width, height: 263))
            imgView.clipsToBounds = true
            imgView.contentMode = .scaleToFill
            imgView.image = UIImage(named: images[i])
            scrollView.addSubview(imgView)
        }
        scrollView.contentSize = CGSize(width: CGFloat(images.count) * container.bounds.width, height: 263)
    }
    
    
    public func cellSize(collectionView: UICollectionView, space: CGFloat, cellsAcross: CGFloat)-> CGSize{
        let cellsAcross: CGFloat = 3
        let spaceBetweenCells: CGFloat = 2
        let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: width, height: width)
    }
}
