//
//  DestAttractCollectionViewCell.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit

class DestAttractCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var provinceLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var attractionLabel: UILabel!
    
    var attraction: AttractionsDistrict?{
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (attraction?.displayImage ?? "")))
            attractionLabel.text = attraction?.title
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
