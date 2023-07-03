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
    
    @IBOutlet weak var unreadView: UIView!
    @IBOutlet weak var unreadLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    var user: LoadedConversationUser? {
        didSet{
            userProfileImageView.sd_setImage(with: URL(string: Helper.shared.getOtherProfileImage(urlString: user?.profileImage ?? "")), placeholderImage: UIImage(named: "user"))
            nameLabel.text = user?.name?.capitalized
            detailLabel.text = user?.username
            let unread = user?.unreadMessages
            unreadLabel.text = "\(unread ?? 0)"
            unreadView.isHidden = unread == 0 ? true : false
        }
    }
    var deleteHandler: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteConversation(_ sender: Any) {
        deleteHandler?()
    }
}
