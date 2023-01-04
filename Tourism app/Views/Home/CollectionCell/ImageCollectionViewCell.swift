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
        // Initialization code
    }

    @IBOutlet weak var imgView: UIImageView!
    var images: GalleryRows?{
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (images?.image_url ?? "")))
        }
    }
    
}
