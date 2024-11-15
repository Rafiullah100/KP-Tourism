//
//  DestProductCollectionViewCell.swift
//  Tourism app
//
//  Created by Rafi on 13/10/2022.
//

import UIKit

class DestProductCollectionViewCell: UICollectionViewCell {
    static var cellIdentifier = "cell_identifier"

    @IBOutlet weak var uploadTimeLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    
    var product: LocalProduct?{
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (product?.previewImage ?? "")), placeholderImage: UIImage(named: "placeholder"))
            productNameLabel.text = "\(product?.title ?? "")"
            ownerImageView.sd_setImage(with: URL(string: Route.baseUrl + (product?.users.profileImage ?? "")))
            ownerNameLabel.text = "\(product?.users.name ?? "")"
            locationLabel.text = "\(product?.districts.title ?? "")"
            uploadTimeLabel.text = "\(product?.createdAt ?? "")"
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.borderWidth = 0.5
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.layer.cornerRadius = 5.0
    }

}

