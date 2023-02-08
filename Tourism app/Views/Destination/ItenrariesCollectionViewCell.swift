//
//  ItenrariesCollectionViewCell.swift
//  Tourism app
//
//  Created by Rafi on 13/10/2022.
//

import UIKit
import SDWebImage
class ItenrariesCollectionViewCell: UICollectionViewCell {
    static var cellIdentifier = "cell_identifier"
    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var itinrary: ItinraryRow? {
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (itinrary?.thumbnailImage ?? "")))
            nameLabel.text = itinrary?.title
            descriptionLabel.text = itinrary?.description
//            dateLabel.text = itinrary.
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.borderWidth = 0.5
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.layer.cornerRadius = 5.0
    }

}

