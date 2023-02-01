//
//  AttractionTableViewCell.swift
//  Tourism app
//
//  Created by Rafi on 19/10/2022.
//

import UIKit
import ImageSlideshow
class AttractionTableViewCell: UITableViewCell {

    
    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    @IBOutlet weak var label: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()

    }

    var imageSDWebImageSrc = [SDWebImageSource]()
    
    var attraction: AttractionsDistrict? {
        didSet{
            label.text = attraction?.title
            imageSDWebImageSrc = []
            attraction?.attractionGalleries?.forEach({ attration in
                let imageUrl = SDWebImageSource(urlString: Route.baseUrl + (attration.imageURL ?? "" ))
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
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favoriteBtnAction(_ sender: Any) {
    }
}
