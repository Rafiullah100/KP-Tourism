//
//  WishlistCollectionViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/8/22.
//

import UIKit
import SDWebImage
class WishlistCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    var postWishlist: PostWishlistModel?{
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (postWishlist?.post?.post?.postFiles?[0].imageURL ?? "")), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    var attractionWishlist: AttractionWishlistModel?{
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (attractionWishlist?.attraction?.previewImage ?? "")), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    var districtWishlist: DistrictWishlistModel?{
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (districtWishlist?.district?.previewImage ?? "")), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    var packageWishlist: PackageWishlistModel?{
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (packageWishlist?.tourPackage?.previewImage ?? "")), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    var productWishlist: ProductWishlistModel?{
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (productWishlist?.localProduct.previewImage ?? "")), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(self.tag)
        // Initialization code
    }

}
