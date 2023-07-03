//
//  ItenrariesCollectionViewCell.swift
//  Tourism app
//
//  Created by Rafi on 13/10/2022.
//

import UIKit
import SDWebImage
class ItenrariesCollectionViewCell: UICollectionViewCell {
    static var cellIdentifier = "cell_identifier"
    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    var itinrary: ItinraryRow? {
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (itinrary?.previewImage ?? "")))
            nameLabel.text = itinrary?.title
            descriptionLabel.text = itinrary?.description?.stripOutHtml()
            dateLabel.text = itinrary?.activities[0].departureDate
            locationLabel.text = itinrary?.activities[0].toPlace
            daysLabel.text = "\(itinrary?.activities.count ?? 0) days"
            viewLabel.text = "\(itinrary?.viewsCounter ?? 0)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.borderWidth = 0.5
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.layer.cornerRadius = 5.0
    }

}

