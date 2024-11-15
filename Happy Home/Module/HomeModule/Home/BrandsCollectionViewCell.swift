//
//  CategoriesCollectionViewCell.swift
//  HappyHome
//
//  Created by NGEN on 01/11/2024.
//

import UIKit

class BrandsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var categoryImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = bgView.frame.width*0.5
    }

  

}
