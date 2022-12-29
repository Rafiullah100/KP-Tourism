//
//  AdventureTableViewCell.swift
//  Tourism app
//
//  Created by Rafi on 19/10/2022.
//

import UIKit
import SDWebImage
class AdventureTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var adventure: Adventure?{
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (adventure?.thumbnailImage ?? "")))
            titleLable.text = adventure?.title
            descriptionLabel.text = adventure?.adventureDescription
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
