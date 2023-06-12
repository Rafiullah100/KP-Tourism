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
        self.like(route: .doWishApi, method: .post, parameters: ["section_id": self.attraction?.id ?? 0, "section": "attraction"], model: SuccessModel.self)
    }
    
    func like<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, showLoader: false, parameters: parameters, model: model) { result in
            switch result {
            case .success(let wish):
                let successDetail = wish as? SuccessModel
                self.favoriteBtn.setImage(successDetail?.message == "Wishlist Added" ? UIImage(named: "fav") : UIImage(named: "unfavorite-gray"), for: .normal)
                self.likeButtonTappedHandler?()
            case .failure(let error):
                print(error)
            }
        }
    }
}
