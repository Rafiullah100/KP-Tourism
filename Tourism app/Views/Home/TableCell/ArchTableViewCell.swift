//
//  ArchTableViewCell.swift
//  Tourism app
//
//  Created by Rafi on 08/11/2022.
//

import UIKit
import ImageSlideshow
class ArchTableViewCell: UITableViewCell {

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
            districtLabel.text = archeology?.attractions.title
            archeologyLabel.text = archeology?.attractions.title
            imageSDWebImageSrc = []
//            archeology?.forEach({ attration in
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
