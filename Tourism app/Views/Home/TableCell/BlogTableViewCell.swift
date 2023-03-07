//
//  BlogTableViewCell.swift
//  Tourism app
//
//  Created by Rafi on 17/11/2022.
//

import UIKit

class BlogTableViewCell: UITableViewCell {

    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    var blog: Blog?{
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (blog?.previewImage ?? "")))
            titleLabel.text = blog?.title
            commentsLabel.text = "\(blog?.comments.commentsCount ?? 0)"
            likesLabel.text = "\(blog?.likes.likesCount ?? 0)"
            locationLabel.text = "\(blog?.districts.title ?? ""), \(blog?.attractions.title ?? "")"
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

