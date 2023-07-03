//
//  ProductTableViewCell.swift
//  Tourism app
//
//  Created by Rafi on 19/10/2022.
//

import UIKit
import SDWebImage
class ProductTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var uploadedTimeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ownerNameLAbel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var ownerImageView: UIImageView!
    
    private var product: LocalProduct?
    var wishlistButtonTappedHandler: (() -> Void)?

    func configure(product: LocalProduct) {
        self.product = product
        favouriteButton.isHidden = Helper.shared.hideWhenNotLogin()
        if product.isWished == 0 {
            favouriteButton.setBackgroundImage(UIImage(named: "unfavorite-gray"), for: .normal)
        }
        else{
            favouriteButton.setBackgroundImage(UIImage(named: "fav"), for: .normal)
        }
        thumbnailImageView.sd_setImage(with: URL(string: Route.baseUrl + (product.previewImage)), placeholderImage: UIImage(named: "placeholder"))
        productNameLabel.text = "\(product.title)"
//        ownerImageView.sd_setImage(with: URL(string: Route.baseUrl + (product.users.profileImage)))
        ownerImageView.sd_setImage(with: URL(string: Helper.shared.getOtherProfileImage(urlString: product.users.profileImage)))
        ownerNameLAbel.text = "\(product.users.name)".capitalized
        locationLabel.text = "\(product.districts.title)"
        uploadedTimeLabel.text =  "\(product.createdAt ?? "")"
    }
//    var product: LocalProduct?{
//        didSet{
//            favouriteButton.isHidden = Helper.shared.hideWhenNotLogin()
//            if product?.isWished == 0 {
//                favouriteButton.setBackgroundImage(UIImage(named: "unfavorite-gray"), for: .normal)
//            }
//            else{
//                favouriteButton.setBackgroundImage(UIImage(named: "fav"), for: .normal)
//            }
//            thumbnailImageView.sd_setImage(with: URL(string: Route.baseUrl + (product?.previewImage ?? "")), placeholderImage: UIImage(named: "placeholder"))
//            productNameLabel.text = "\(product?.title ?? "")"
//            ownerImageView.sd_setImage(with: URL(string: Route.baseUrl + (product?.users.profileImage ?? "")))
//            ownerNameLAbel.text = "\(product?.users.name ?? "")"
//            locationLabel.text = "\(product?.districts.title ?? "")"
//            uploadedTimeLabel.text =  "\(product?.createdAt ?? "")"
//        }
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @IBAction func favoriteBtnAction(_ sender: Any) {
        guard UserDefaults.standard.userID != 0, UserDefaults.standard.userID != nil else { return }
        self.wishList(parameters: ["section_id": self.product?.id ?? 0, "section": "local_product"])

    }
    
    func wishList(parameters: [String: Any]) {
        URLSession.shared.request(route: .doWishApi, method: .post, showLoader: false, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let wish):
                self.favouriteButton.setBackgroundImage(wish.message == "Wishlist Added" ? UIImage(named: "fav") : UIImage(named: "unfavorite-gray"), for: .normal)
                self.wishlistButtonTappedHandler?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
