//
//  ArchTableViewCell.swift
//  Tourism app
//
//  Created by Rafi on 08/11/2022.
//

import UIKit
import ImageSlideshow
class ArchTableViewCell: UITableViewCell {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var imgBGView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var archeologyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var imageSDWebImageSrc = [SDWebImageSource]()
    
    var archeology: Archeology? {
        didSet{
            archeologyLabel.text = archeology?.attractions?.title?.stripOutHtml()
            districtLabel.text = archeology?.attractions?.description?.stripOutHtml()
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (archeology?.image_url ?? "")))
            imageSDWebImageSrc = []
            bottomView.viewShadow()
//            imgBGView.roundCorners(corners: [.topRight, .topLeft], radius: 10)
//            archeology?.attractions.forEach({ attration in
//                let imageUrl = SDWebImageSource(urlString: Route.baseUrl + (attration.imageURL ?? ""), placeholder: UIImage(named: "placeholder"))
//                if let sdURL = imageUrl{
//                    imageSDWebImageSrc.append(sdURL)
//                    slideShow.slideshowInterval = 2.0
//                    slideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
//                    slideShow.isUserInteractionEnabled = false
//                    slideShow.setImageInputs(imageSDWebImageSrc)
//                }
//            })
        }
    }
}
