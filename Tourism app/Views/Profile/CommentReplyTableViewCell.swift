//
//  CommentReplyTableViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/24/23.
//

import UIKit

class CommentReplyTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var commentReply: CommentsReply?{
        didSet{
            timeLabel.text = "\(commentReply?.createdAt ?? "")"
            commentLabel.text = "\(commentReply?.reply ?? "")".removeSpaces()
            nameLabel.text = "\(commentReply?.users?.name ?? "")"
            userImageView.sd_setImage(with: URL(string: Helper.shared.getOtherProfileImage(urlString: commentReply?.users?.profileImage ?? "")), placeholderImage: UIImage(named: "user"))
        }
    }
}


