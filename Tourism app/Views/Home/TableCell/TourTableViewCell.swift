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

    var actionBlock: (() -> Void)? = nil
    
    @IBOutlet weak var likesLabel: UILabel!
    var tour: TourPackage?{
        didSet{
            
            if tour?.userWishlist == 1 && tour?.userWishlist != nil {
                favoriteButton.setBackgroundImage(UIImage(named: "fav"), for: .normal)
            }
            else{
                favoriteButton.setBackgroundImage(UIImage(named: "unfavorite-gray"), for: .normal)
            }
            
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (tour?.preview_image ?? "")))
            label.text = tour?.title
            destinationLabel.text = tour?.to_districts?.title
            viewsLabel.text = "\(tour?.views_counter ?? 0)"
            likesLabel.text = "\(tour?.likes?.count ?? 0)"
            commentsLabel.text = "\(tour?.comments?.count ?? 0)"

//            if tour?.likes?.count != 0 {
//                likesLabel.text = "\(tour?.likes?[0].likesCount ?? 0)"
//            }
            
//            if tour?.comments?.count != 0 {
//                commentsLabel.text = "\(tour?.comments?[0].commentsCount ?? 0)"
//            }
            
            
//            imgView.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favoriteButton.isHidden = Helper.shared.hideWhenNotLogin()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favoriteBtnAction(_ sender: Any) {
        guard UserDefaults.standard.userID != 0, UserDefaults.standard.userID != nil else { return }
        actionBlock?()
    }
}
