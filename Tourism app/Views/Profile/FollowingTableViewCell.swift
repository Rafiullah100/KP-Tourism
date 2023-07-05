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
            imgView.sd_setImage(with: URL(string: Helper.shared.getOtherProfileImage(urlString: following?.followerUser.profileImage ?? "")), placeholderImage: UIImage(named: "user"))
            nameLabel.text = following?.followerUser.name?.capitalized
            followButton.setTitle("UNFollow", for: .normal)
//            followButton.setTitle(following?.isFollowing == 1 ? "UNFollow" : "Follow", for: .normal)
        }
    }
    
    var follower: FollowerRow? {
        didSet{
            imgView.sd_setImage(with: URL(string: Helper.shared.getOtherProfileImage(urlString: follower?.followingUser.profileImage ?? "")), placeholderImage: UIImage(named: "user"))
            nameLabel.text = follower?.followingUser.name?.capitalized
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
