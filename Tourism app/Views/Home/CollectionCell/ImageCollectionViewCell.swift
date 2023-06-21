//
//  ImageCollectionViewCell.swift
//  Tourism app
//
//  Created by Rafi on 20/10/2022.
//

import UIKit
import SDWebImage
class ImageCollectionViewCell: UICollectionViewCell {
    static var cellIdentifier = "cell_identifier"
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var imgView: UIImageView!
    var images: GalleryRows?{
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (images?.image_url ?? "")), placeholderImage: UIImage(named: "thumbnail.jpg")) { _,_,_,_  in
                self.typeImageView.isHidden = false
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.typeImageView.isHidden = true
    }
}
