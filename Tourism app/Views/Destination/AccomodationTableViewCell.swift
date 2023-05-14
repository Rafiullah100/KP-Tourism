//
//  AccomodationTableViewCell.swift
//  Tourism app
//
//  Created by Rafi on 13/10/2022.
//

import UIKit
import SDWebImage
class AccomodationTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgageBGView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    static var celldentifier = "cell_identifier"
    
    
    @IBOutlet weak var covidView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var accomodationDetail: Accomodation?{
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (accomodationDetail?.previewImage ?? "")))
            nameLabel.text = accomodationDetail?.title
            descriptionLabel.text = accomodationDetail?.description
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 10
        bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        imgageBGView.clipsToBounds = true
        imgageBGView.layer.cornerRadius = 10
        imgageBGView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        bottomView.viewShadow()
        covidView.viewShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
