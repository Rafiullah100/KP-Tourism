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
    
    var imageSDWebImageSrc = [SDWebImageSource]()

    private var archeology: Archeology?
    var wishlistButtonTappedHandler: (() -> Void)?

    func configure(archeology: Archeology) {
        self.archeology = archeology
        favoriteButton.isHidden = Helper.shared.hideWhenNotLogin()
        archeologyLabel.text = archeology.attractions.title?.stripOutHtml()
        districtLabel.text = archeology.attractions.description?.stripOutHtml()
        imgView.sd_setImage(with: URL(string: Route.baseUrl + (archeology.attractions.displayImage ?? "")))
        imageSDWebImageSrc = []
        
        if archeology.attractions.isWished == 0 {
            favoriteButton.setBackgroundImage(UIImage(named: "unfavorite-gray"), for: .normal)
        }
        else{
            favoriteButton.setBackgroundImage(UIImage(named: "fav"), for: .normal)
        }
    }
    
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
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    @IBAction func LikeBtnAction(_ sender: Any) {
        guard UserDefaults.standard.userID != 0, UserDefaults.standard.userID != nil else { return }
        let archeologyID = self.archeology?.attractions.id
        self.wishList(parameters: ["section_id": archeologyID ?? 0, "section": "attraction"])
    }
    
    func wishList(parameters: [String: Any]) {
        URLSession.shared.request(route: .doWishApi, method: .post, showLoader: false, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let wish):
                self.favoriteButton.setBackgroundImage(wish.message == "Wishlist Added" ? UIImage(named: "fav") : UIImage(named: "unfavorite-gray"), for: .normal)
                self.wishlistButtonTappedHandler?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
