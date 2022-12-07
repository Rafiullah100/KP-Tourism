//
//  ProfileCollectionViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/5/22.
//

import UIKit

class StatusCollectionViewCell: UICollectionViewCell {

    enum FeedCellType {
        case userSelf
        case other
    }
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    
    var cellType: FeedCellType? {
        didSet{
            switch cellType {
            case .userSelf:
                label.isHidden = true
                statusImageView.isHidden = false
            case .other:
                label.isHidden = false
                statusImageView.isHidden = true
            case .none:
                break
            }
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
