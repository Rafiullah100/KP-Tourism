//
//  ArchTableViewCell.swift
//  Tourism app
//
//  Created by Rafi on 08/11/2022.
//

import UIKit
import ImageSlideshow
class ArchTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var imgBGView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var archeologyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 10
        bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        imgBGView.clipsToBounds = true
        imgBGView.layer.cornerRadius = 10
        imgBGView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomView.viewShadow()
    }
    
    var actionBlock: (() -> Void)? = nil


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var imageSDWebImageSrc = [SDWebImageSource]()
    
    var archeology: Archeology? {
        didSet{
            favoriteButton.isHidden = Helper.shared.hideWhenNotLogin()
            archeologyLabel.text = archeology?.attractions.title?.stripOutHtml()
            districtLabel.text = archeology?.attractions.description?.stripOutHtml()
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (archeology?.attractions.displayImage ?? "")))
            imageSDWebImageSrc = []
            
            if archeology?.attractions.isWished == 0 {
                favoriteButton.setBackgroundImage(UIImage(named: "unfavorite-gray"), for: .normal)
            }
            else{
                favoriteButton.setBackgroundImage(UIImage(named: "fav"), for: .normal)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    @IBAction func LikeBtnAction(_ sender: Any) {
        guard UserDefaults.standard.userID != 0, UserDefaults.standard.userID != nil else { return }
        actionBlock?()
    }
}
