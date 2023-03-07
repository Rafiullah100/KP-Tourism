//
//  VirtualCollectionViewCell.swift
//  Tourism app
//
//  Created by Rafi on 20/10/2022.
//

import UIKit

class VirtualCollectionViewCell: UICollectionViewCell {
    static var cellIdentifier = "cell_identifier"
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var images: GalleryRows?{
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (images?.image_url ?? "")), placeholderImage: UIImage(named: "thumbnail.jpg"))
//            imgView.image = Helper.shared.getThumbnailImage(forUrl: URL(string: Route.baseUrl + (images?.video_url ?? "")))
        }
    }

}
