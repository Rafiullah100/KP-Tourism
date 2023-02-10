//
//  ExploreTableViewCell.swift
//  Tourism app
//
//  Created by Rafi on 19/10/2022.
//

import UIKit
import ImageSlideshow
class ExploreTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var favoriteButton: UIButton!
    var actionBlock: (() -> Void)? = nil
    @IBOutlet weak var districtLabel: UILabel!
    
    @IBOutlet weak var kpLabel: UILabel!
    var imageSDWebImageSrc = [SDWebImageSource]()
    
    var district: ExploreDistrict? {
        didSet{
            if district?.userLike == 0 {
                favoriteButton.setBackgroundImage(UIImage(named: "unfavorite-gray"), for: .normal)
            }
            else{
                favoriteButton.setBackgroundImage(UIImage(named: "favorite"), for: .normal)
            }
            districtLabel.text = district?.title
            imageSDWebImageSrc = []
            DispatchQueue.main.async {
                self.district?.attractions.forEach({ attration in
                    let imageUrl = SDWebImageSource(urlString: Route.baseUrl + (attration.previewImage ))
                    if let sdURL = imageUrl{
                        self.imageSDWebImageSrc.append(sdURL)
                        self.slideShow.slideshowInterval = 2.0
                        self.slideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
                        self.slideShow.isUserInteractionEnabled = false
                        self.slideShow.setImageInputs(self.imageSDWebImageSrc)
                    }
                })
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static func configureCell() {
        //
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
        
    @IBAction func favoriteBtn(_ sender: Any) {
        actionBlock?()
    }
}

