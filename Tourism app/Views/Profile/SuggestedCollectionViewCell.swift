//
//  SuggestedCollectionViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 5/14/23.
//

import UIKit
import SDWebImage
class SuggestedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var followAction: (() -> Void)? = nil

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var users: SuggestedUser? {
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (users?.profileImage ?? "")))
            nameLabel.text = users?.name?.capitalized
        }
    }

    @IBAction func followBtnAction(_ sender: Any) {
        followAction?()
    }
}
