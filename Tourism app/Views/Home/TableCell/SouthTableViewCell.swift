//
//  SouthTableViewCell.swift
//  Tourism app
//
//  Created by Rafi on 19/10/2022.
//

import UIKit
import SDWebImage
import ImageSlideshow

class SouthTableViewCell: UITableViewCell {

    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var kpLabel: UILabel!
    @IBOutlet weak var districtLabel: UILabel!
    var imageSDWebImageSrc = [SDWebImageSource]()

    var district: ExploreDistrict?{
        didSet{
            districtLabel.text = district?.title
            imageSDWebImageSrc = []
            district?.attractions.forEach({ attration in
                let imageUrl = SDWebImageSource(urlString: Route.baseUrl + (attration.previewImage ?? ""))
                if let sdURL = imageUrl{
                    imageSDWebImageSrc.append(sdURL)
                    slideShow.slideshowInterval = 2.0
                    slideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
                    slideShow.isUserInteractionEnabled = false
                    slideShow.setImageInputs(imageSDWebImageSrc)
                }
            })
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
