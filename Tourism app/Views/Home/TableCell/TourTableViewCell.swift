//
//  TourTableViewCell.swift
//  Tourism app
//
//  Created by Rafi on 19/10/2022.
//

import UIKit
import AARatingBar
class TourTableViewCell: UITableViewCell {

    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

    @IBOutlet weak var doscountLabel: UILabel!
    
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var likesLabel: UILabel!
    
    
    private var tour: TourPackage?
    var wishlistButtonTappedHandler: (() -> Void)?

    func configure(tour: TourPackage) {
        self.tour = tour
        favoriteButton.isHidden = Helper.shared.hideWhenNotLogin()
        if tour.userWishlist == 1 && tour.userWishlist != nil {
            favoriteButton.setBackgroundImage(UIImage(named: "fav"), for: .normal)
        }
        else{
            favoriteButton.setBackgroundImage(UIImage(named: "unfavorite-gray"), for: .normal)
        }
        
        imgView.sd_setImage(with: URL(string: Route.baseUrl + (tour.preview_image ?? "")))
        label.text = tour.title
        destinationLabel.text = tour.to_districts?.title
        viewsLabel.text = "\(tour.views_counter ?? 0)"
        likesLabel.text = "\(tour.likes?.count ?? 0)"
        commentsLabel.text = "\(tour.comments?.count ?? 0)"
        doscountLabel.text = "\(tour.discount ?? "")"
        discountView.isHidden = tour.discount == "0" ? true : false
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        discountView.roundCorners(corners: [.topRight, .bottomRight], radius: 20.0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favoriteBtnAction(_ sender: Any) {
        guard UserDefaults.standard.userID != 0, UserDefaults.standard.userID != nil else { return }
        let packageID = self.tour?.id
        self.wishList(route: .doWishApi, method: .post, parameters: ["section_id": packageID ?? 0, "section": "tour_package"], model: SuccessModel.self)
    }
    
    func wishList<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, showLoader: false, parameters: parameters, model: model) { result in
            switch result {
            case .success(let wish):
                let successDetail = wish as? SuccessModel
                self.favoriteButton.setBackgroundImage(successDetail?.message == "Wishlist Added" ? UIImage(named: "fav") : UIImage(named: "unfavorite-gray"), for: .normal)
                self.wishlistButtonTappedHandler?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
