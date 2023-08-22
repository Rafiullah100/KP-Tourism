//
//  EventTableViewCell.swift
//  Tourism app
//
//  Created by Rafi on 17/11/2022.
//

import UIKit
import SDWebImage

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var opendateLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var statusView: UIView!
    
    @IBOutlet weak var interestGoingLabel: UILabel!
    @IBOutlet weak var counterView: UIView!
    var wishlistButtonTappedHandler: (() -> Void)?

    @IBOutlet weak var registrationLabel: UILabel!
    var event: EventListModel?{
        didSet{
            favoriteButton.isHidden = Helper.shared.hideWhenNotLogin()
            if event?.userWishlist == 0 {
                favoriteButton.setBackgroundImage(UIImage(named: "unfavorite-gray"), for: .normal)
            }
            else{
                favoriteButton.setBackgroundImage(UIImage(named: "fav"), for: .normal)
            }
            registrationLabel.text = "Registration \(event?.isExpired ?? "")"
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (event?.previewImage ?? "")))
            titleLabel.text = event?.title
            typeLabel.text = event?.locationTitle
            opendateLabel.text = "\(event?.startDate ?? "") | \(event?.isExpired ?? "")"
            interestGoingLabel.text = "\(event?.usersInterestCount ?? 0)"
            if event?.isExpired == "Closed" {
                statusView.backgroundColor = .red
            }
            else{
                statusView.backgroundColor = Constants.appColor
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        counterView.layer.shadowColor = UIColor.lightGray.cgColor
        counterView.layer.shadowOffset = CGSize(width: 1, height: 1)
        counterView.layer.shadowOpacity = 0.4
        counterView.layer.shadowRadius = 2.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        statusView.roundCorners(corners: [.topLeft], radius: 10.0)
        // Configure the view for the selected state
    }
    
    @IBAction func favoriteBtnAction(_ sender: Any) {
        guard UserDefaults.standard.userID != 0, UserDefaults.standard.userID != nil else { return }
        self.wishList(parameters: ["section_id": self.event?.id ?? 0, "section": "social_event"])
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
