//
//  DestProductCollectionViewCell.swift
//  Tourism app
//
//  Created by Rafi on 13/10/2022.
//

import UIKit

class DestProductCollectionViewCell: UICollectionViewCell {
    static var cellIdentifier = "cell_identifier"

    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.borderWidth = 0.5
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.layer.cornerRadius = 5.0    }

}

