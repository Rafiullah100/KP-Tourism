//
//  VisitKPTableViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/27/23.
//

import UIKit
import SDWebImage
class VisitKPTableViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    
    
    var visit: VisitKPRow?{
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (visit?.thumbnailImage ?? "")))
            label.text = "\(visit?.title ?? "")"
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
