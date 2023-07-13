//
//  BlogTableViewCell.swift
//  Tourism app
//
//  Created by Rafi on 17/11/2022.
//

import UIKit

class BlogTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
//    @IBOutlet weak var interestGoingLabel: UILabel!
//    @IBOutlet weak var counterView: UIView!
   
    
    @IBOutlet weak var favoriteButton: UIButton!
    var wishlistButtonTappedHandler: (() -> Void)?
    
    var blog: Blog?{
        
        didSet{
            if blog?.isWished == 0 {
                favoriteButton.setBackgroundImage(UIImage(named: "unfavorite-gray"), for: .normal)
            }
            else{
                favoriteButton.setBackgroundImage(UIImage(named: "fav"), for: .normal)
            }
            userImageView.sd_setImage(with: URL(string: Route.baseUrl + (blog?.users.profileImage ?? "")))
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (blog?.previewImage ?? "")))
            titleLabel.text = blog?.title
            commentsLabel.text = "\(blog?.comments.commentsCount ?? 0)"
            likesLabel.text = "\(blog?.likes.likesCount ?? 0)"
            locationLabel.text = "\(blog?.districts.title ?? ""), \(blog?.attractions.title ?? "")"
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userImageView.layer.cornerRadius = userImageView.frame.height * 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favoriteBtnAction(_ sender: Any) {
        guard UserDefaults.standard.userID != 0, UserDefaults.standard.userID != nil else { return }
        self.wishList(parameters: ["section_id": self.blog?.id ?? 0, "section": "blog"])
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

