//
//  FollowerTableViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/7/22.
//

import UIKit
import SDWebImage
class FollowingTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var followButton: UIButton!
    var unfollowAction: (() -> Void)? = nil

    
    var following: FollowingRow? {
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (following?.followerUser.profileImage ?? "")))
            nameLabel.text = following?.followerUser.name?.capitalized
            followButton.setTitle("UNFollow", for: .normal)
        }
    }
    
    var follower: FollowerRow? {
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (follower?.followerUser.profileImage ?? "")))
            nameLabel.text = follower?.followerUser.name?.capitalized
            followButton.setTitle(follower?.isFollowing == 1 ? "UNFollow" : "Follow", for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func followingBtnAction(_ sender: Any) {
        unfollowAction?()
    }
}
