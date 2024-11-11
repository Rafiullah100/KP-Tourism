//
//  ProductCategoryCollectionViewCell.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/9/24.
//

import UIKit

class ProductCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.layer.cornerRadius = bgView.frame.height * 0.5
        bgView.layer.masksToBounds = true
    }
    
    func configure(with category: String, isSelected: Bool) {
        label.text = category
        label.font = UIFont(name: isSelected ? Constants.fontNameBold : Constants.fontNameMedium, size: 15.0)
        label.backgroundColor = isSelected ? .black : .clear
        label.textColor = isSelected ? .white : CustomColor.categoryColor.color
        bgView.backgroundColor = isSelected ? .black : .clear
    }

}
