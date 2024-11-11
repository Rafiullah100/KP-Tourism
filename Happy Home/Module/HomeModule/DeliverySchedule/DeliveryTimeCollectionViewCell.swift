//
//  DeliveryTimeCollectionViewCell.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/3/24.
//

import UIKit

class DeliveryTimeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!

    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var checkImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(isSelected: Bool) {
        imageView.isHidden = !isSelected
        if isSelected {
            label.font = UIFont(name: Constants.fontNameSemoBold, size: 13.0)
            bgView.backgroundColor = CustomColor.yellowColor.color
            bgView.borderWidth = 0.0
        }
        else{
            label.font = UIFont(name: Constants.fontRegular, size: 13.0)
            bgView.backgroundColor = .clear
            bgView.borderWidth = 1.0
        }
    }
}
