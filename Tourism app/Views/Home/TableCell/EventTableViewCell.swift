//
//  EventTableViewCell.swift
//  Tourism app
//
//  Created by Rafi on 17/11/2022.
//

import UIKit
import SDWebImage

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var opendateLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var statusView: UIView!
    
    @IBOutlet weak var counterView: UIView!
    var event: EventListModel?{
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (event?.thumbnailImage ?? "")))
            titleLabel.text = event?.title
            typeLabel.text = event?.locationTitle
            opendateLabel.text = "\(event?.startDate ?? "") | \(event?.isExpired ?? "")"
            if event?.isExpired == "Closed" {
                statusView.backgroundColor = .red
            }
            else{
                statusView.backgroundColor = .green
            }
            shadow()
        }
    }
    
    
    func shadow()  {
        counterView.layer.shadowColor = UIColor.lightGray.cgColor
        counterView.layer.shadowOffset = CGSize(width: 1, height: 1)
        counterView.layer.shadowOpacity = 0.4
        counterView.layer.shadowRadius = 2.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        statusView.roundCorners(corners: [.topLeft], radius: 10.0)
        // Configure the view for the selected state
    }
    
}
