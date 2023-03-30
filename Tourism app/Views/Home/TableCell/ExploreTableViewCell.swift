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
    var slideArray = [String]()
    
    var district: ExploreDistrict? {
        didSet{
            if district?.isWished == 0 {
                favoriteButton.setBackgroundImage(UIImage(named: "unfavorite-gray"), for: .normal)
            }
            else{
                favoriteButton.setBackgroundImage(UIImage(named: "favorite"), for: .normal)
            }
            districtLabel.text = district?.title
            slideArray = []
            slideArray.append(district?.previewImage ?? "")
            self.district?.attractions.forEach({ attration in
                self.slideArray.append(attration.previewImage ?? "")
            })
            imageSDWebImageSrc = []
            DispatchQueue.main.async {
                for i in 0..<self.slideArray.count{
                    if i > 2{
                        break
                    }
                    let imageUrl = SDWebImageSource(urlString: Route.baseUrl + self.slideArray[i])
                    if let sdURL = imageUrl{
                        self.imageSDWebImageSrc.append(sdURL)
                        self.slideShow.slideshowInterval = 2.0
                        self.slideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
                        self.slideShow.isUserInteractionEnabled = false
                        self.slideShow.setImageInputs(self.imageSDWebImageSrc)
                    }
                }
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
        guard UserDefaults.standard.userID != 0, UserDefaults.standard.userID != nil else { return }
        actionBlock?()
    }
}

