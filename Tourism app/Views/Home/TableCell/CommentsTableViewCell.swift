//
//  CommentsTableViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/17/23.
//

import UIKit
import SDWebImage
class CommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    
    var comment: CommentsRows?{
        didSet{
            timeLabel.text = "\(comment?.createdAt ?? "")"
            commentLabel.text = "\(comment?.comment ?? "")"
            nameLabel.text = "\(comment?.users.name ?? "")"
            userImageView.sd_setImage(with: URL(string: Route.baseUrl + (comment?.users.profileImage ?? "")), placeholderImage: UIImage(named: "user"))
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
