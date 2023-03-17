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
    
    var post: UserPostRow? {
        didSet {
            if post?.postFiles.count ?? 0 > 0{
                imgView.sd_setImage(with: URL(string: Route.baseUrl + (post?.postFiles[0].imageURL ?? "")))
            }
        }
    }
    
    var product: UserProductRow? {
        didSet {
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (product?.previewImage ?? "")))
        }
    }
//
    var blog: UserBlogRow? {
        didSet {
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (blog?.previewImage ?? "") ))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
