//
//  DestAttractCollectionViewCell.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit

class DestAttractCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var favoriteBtn: UIButton!
    
    @IBOutlet weak var provinceLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var attractionLabel: UILabel!
    private var attraction: AttractionsDistrict?
    var likeButtonTappedHandler: (() -> Void)?

    func configure(attraction: AttractionsDistrict) {
        self.attraction = attraction
        favoriteBtn.setImage(self.attraction?.isWished == 1 ? UIImage(named: "fav") : UIImage(named:  "unfavorite-gray"), for: .normal)
        imgView.sd_setImage(with: URL(string: Route.baseUrl + (self.attraction?.previewImage ?? "")))
//        downloadImageSize(from: Route.baseUrl + (self.attraction?.previewImage ?? ""))
        attractionLabel.text = self.attraction?.title
        favoriteBtn.isHidden = Helper.shared.hideWhenNotLogin()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func likeBtnActio(_ sender: Any) {
        self.like(parameters: ["section_id": self.attraction?.id ?? 0, "section": "attraction"])
    }
    
    func like(parameters: [String: Any]) {
        URLSession.shared.request(route: .doWishApi, method: .post, showLoader: false, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let wish):
                self.favoriteBtn.setImage(wish.message == "Wishlist Added" ? UIImage(named: "fav") : UIImage(named: "unfavorite-gray"), for: .normal)
                self.likeButtonTappedHandler?()
            case .failure(let error):
                print(error)
            }
        }
    }
}
