//
//  allProductsCollectionViewCell.swift
//  HappyHome
//
//  Created by NGEN on 07/11/2024.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var expiredDateLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet var percentageLbl: UILabel!
    @IBOutlet var productImg: UIImageView!
    @IBOutlet var productTitleLbl: UILabel!
    @IBOutlet var expireDate: UILabel!
    @IBOutlet var newPriceLabel: UILabel!
    @IBOutlet var oldPrice: UILabel!
    
    @IBOutlet weak var addView: UIView!
    
    @IBOutlet var quantityLbl: UILabel!
    
    var didTapButton: (() -> Void)?

    
    @IBAction func Increment(_ sender: Any) {
        
        
    }

    @IBAction func Decrement(_ sender: Any) {
        
    }

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        expiredDateLabel.text = LocalizationKeys.expiredDate.rawValue.localizeString()
        oldPrice.text = "6.4 \(LocalizationKeys.riyal.rawValue.localizeString())"
        newPriceLabel.text = "5.4 \(LocalizationKeys.riyal.rawValue.localizeString())"
        percentageLbl.text = "-30% \nOFF"
    }

    
    @IBAction func addViewButtonAction(_ sender: Any) {
//        didTapButton?()
        addView.isHidden = true
        
    }
    @IBAction func favoriteButtonAction(_ sender: Any) {
        
        if favoriteImageView.image == UIImage(named: "favorite"){
            favoriteImageView.image = UIImage(named: "like")
        }
        else{
            favoriteImageView.image = UIImage(named: "favorite")
        }
    }
    
}
