//
//  FeedTableViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/5/22.
//

import UIKit
import SDWebImage
class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgbgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    @IBOutlet weak var commentCountLabel: UILabel!
    
    var feed: FeedModel? {
        didSet {
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (feed?.postImages[0].imageURL ?? "")))
            postLabel.text = feed?.description
            nameLabel.text = feed?.users.name
            userImageView.sd_setImage(with: URL(string: Route.baseUrl + (feed?.users.profileImage ?? "")))
            likeCountLabel.text = "\(feed?.likesCount ?? 0)"
            commentCountLabel.text = "\(feed?.commentsCount ?? 0)"
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
