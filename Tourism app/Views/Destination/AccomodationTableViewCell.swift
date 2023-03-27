//
//  AccomodationTableViewCell.swift
//  Tourism app
//
//  Created by Rafi on 13/10/2022.
//

import UIKit
import SDWebImage
class AccomodationTableViewCell: UITableViewCell {
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var familyLabel: UILabel!
    @IBOutlet weak var cancellationLabel: UILabel!
    @IBOutlet weak var breakfastLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    static var celldentifier = "cell_identifier"
    
    
    var accomodationDetail: Accomodation?{
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (accomodationDetail?.previewImage ?? "")))
            titleLabel.text = accomodationDetail?.title
            locationLabel.text = accomodationDetail?.locationTitle
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
