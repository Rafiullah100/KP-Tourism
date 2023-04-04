//
//  POIServiceTableViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/1/22.
//

import UIKit
import SDWebImage
class POIServiceTableViewCell: UITableViewCell {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var poiSubCategory: POIRow?{
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (poiSubCategory?.displayImage ?? "")))
            titleLabel.text = poiSubCategory?.title
            addressLabel.text = poiSubCategory?.locationTitle
        }
    }
    

}
