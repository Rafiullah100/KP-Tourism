//
//  allProductsCollectionViewCell.swift
//  HappyHome
//
//  Created by NGEN on 07/11/2024.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet var percentageLbl: UILabel!
    @IBOutlet var productImg: UIImageView!
    @IBOutlet var productTitleLbl: UILabel!
    @IBOutlet var expireDate: UILabel!
    @IBOutlet var newPrice: UILabel!
    @IBOutlet var oldPrice: UILabel!
    
    @IBOutlet weak var addView: UIView!
    
    @IBOutlet var quantityLbl: UILabel!
    
    var didTapButton: (() -> Void)?

    
    @IBAction func Increment(_ sender: Any) {
        
        
    }

    @IBAction func Decrement(_ sender: Any) {
        
    }

    // Increment & Decrement Functions
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
