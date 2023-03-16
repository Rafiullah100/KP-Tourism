//
//  ChatListTableViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/6/22.
//

import UIKit
import SDWebImage
class ChatListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusIndicator: UIView!
    @IBOutlet weak var userProfileImageView: UIImageView!
    
    var user: ChatUserRow? {
        didSet{
            userProfileImageView.sd_setImage(with: URL(string: Route.baseUrl + (user?.profileImage ?? "")), placeholderImage: UIImage(named: "user"))
            nameLabel.text = user?.name
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
    
}
