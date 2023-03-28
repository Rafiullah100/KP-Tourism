//
//  FollowerTableViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/7/22.
//

import UIKit

class FollowingTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var aboutLabel: UILabel!
    
    var unfollowAction: (() -> Void)? = nil

    
    var user: FollowingRow? {
        didSet{
            nameLabel.text = user?.followingUser?.name
            aboutLabel.text = user?.followingUser?.about
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
