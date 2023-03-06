//
//  FeedTableViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/5/22.
//

import UIKit
import SDWebImage
import ReadMoreTextView
class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgbgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
//    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var textView: ReadMoreTextView!
    
    var feed: FeedModel? {
        didSet {
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (feed?.postImages[0].imageURL ?? "").replacingOccurrences(of: " ", with: "%20")))
            textView.text = feed?.description
            nameLabel.text = feed?.users.name
            userImageView.sd_setImage(with: URL(string: Route.baseUrl + (feed?.users.profileImage ?? "")))
            likeCountLabel.text = "\(feed?.likesCount ?? 0)"
            commentCountLabel.text = "\(feed?.commentsCount ?? 0)"
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        textView.onSizeChange = { _ in }
        textView.shouldTrim = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
