//
//  ProductTableViewCell.swift
//  Tourism app
//
//  Created by Rafi on 19/10/2022.
//

import UIKit
import SDWebImage
class ProductTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var uploadedTimeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ownerNameLAbel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var ownerImageView: UIImageView!
    
    
    var product: LocalProduct?{
        didSet{
            thumbnailImageView.sd_setImage(with: URL(string: Route.baseUrl + (product?.thumbnailImage ?? "")), placeholderImage: UIImage(named: "placeholder"))
            productNameLabel.text = "\(product?.title ?? "")"
            ownerImageView.sd_setImage(with: URL(string: Route.baseUrl + (product?.users.profileImage ?? "")))
            ownerNameLAbel.text = "\(product?.users.name ?? "")"
            locationLabel.text = "\(product?.districts.title ?? "")"
            uploadedTimeLabel.text =  "\(product?.createdAt ?? "")"
        }
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
