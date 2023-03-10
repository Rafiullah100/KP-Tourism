//
//  InvestmentTableViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/7/23.
//

import UIKit
import SDWebImage
class InvestmentTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imageBGView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    var investment: InvestmentRow? {
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (investment?.imageURL ?? "")))
            label.text = investment?.title
            
            bottomView.clipsToBounds = true
            bottomView.layer.cornerRadius = 10
            bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

            imageBGView.clipsToBounds = true
            imageBGView.layer.cornerRadius = 10
            imageBGView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            bottomView.viewShadow()
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
