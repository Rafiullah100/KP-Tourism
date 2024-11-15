//
//  InterestPointCollectionViewCell.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit
import SDWebImage

class InterestPointCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var poiLabel: UILabel!
    var poiCategory: Poicategory?{
        didSet{
            imageView.sd_setImage(with: URL(string: Route.baseUrl + (poiCategory?.icon ?? "")))
            poiLabel.text = poiCategory?.title
            countLabel.text = "\( poiCategory?.count ?? 0 )"
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.viewShadow()
    }

    
    
}

