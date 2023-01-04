//
//  VideoCollectionViewCell.swift
//  Tourism app
//
//  Created by Rafi on 20/10/2022.
//

import UIKit
import SDWebImage
class VideoCollectionViewCell: UICollectionViewCell {
    static var cellIdentifier = "cell_identifier"
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var images: GalleryRows?{
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (images?.image_url ?? "")), placeholderImage: UIImage(named: "placeholder"))
        }
    }
}
