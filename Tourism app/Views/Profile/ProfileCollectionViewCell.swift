//
//  ProfileCollectionViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/7/22.
//

import UIKit
import SDWebImage
class ProfileCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    var image: String? {
        didSet {
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (image ?? "")))
        }
    }
    
    var product: Profileproducts? {
        didSet {
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (product?.preview_image ?? "")))
        }
    }
    
    var blog: ProfileBlogs? {
        didSet {
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (blog?.preview_image ?? "") ))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
