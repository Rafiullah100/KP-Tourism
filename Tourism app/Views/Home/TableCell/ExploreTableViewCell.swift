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
    @IBOutlet weak var districtLabel: UILabel!
    
    @IBOutlet weak var kpLabel: UILabel!
    var imageSDWebImageSrc = [SDWebImageSource]()
    var slideArray = [String]()
    
    private var district: ExploreDistrict?
    var wishlistButtonTappedHandler: (() -> Void)?
    var tappedHandler: (() -> Void)?

    func configure(district: ExploreDistrict) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        slideShow.addGestureRecognizer(tapGesture)
        self.district = district
        kpLabel.text = district.geographicalArea
        favoriteButton.isHidden = Helper.shared.hideWhenNotLogin()
        if district.isWished == 0 {
            favoriteButton.setBackgroundImage(UIImage(named: "unfavorite-gray"), for: .normal)
        }
        else{
            favoriteButton.setBackgroundImage(UIImage(named: "fav"), for: .normal)
        }
        districtLabel.text = district.title
        slideArray = []
        slideArray.append(district.previewImage ?? "")
        self.district?.attractions.forEach({ attration in
            self.slideArray.append(attration.displayImage ?? "")
        })
        print(self.district?.attractions ?? [])
        imageSDWebImageSrc = []
        DispatchQueue.main.async {
            for i in 0..<self.slideArray.count{
                if i > 2{
                    break
                }
                let imageUrl = SDWebImageSource(urlString: Route.baseUrl + self.slideArray[i])
                if let sdURL = imageUrl{
                    self.imageSDWebImageSrc.append(sdURL)
                    self.slideShow.slideshowInterval = 0.0
                    self.slideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
                    self.slideShow.isUserInteractionEnabled = true
                    self.slideShow.contentScaleMode = .scaleToFill
                    self.slideShow.setImageInputs(self.imageSDWebImageSrc)
                }
            }
        }
    }
    
    @objc func imageTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        tappedHandler?()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
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
        self.wishList(parameters: ["section_id": self.district?.id ?? 0, "section": "district"])
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

