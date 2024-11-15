//
//  DestinationCollectionViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 11/22/22.
//

import UIKit

class DestinationCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var label: UILabel!
    var destination: Destination?{
        didSet{
            label.text = destination?.title
            imgView.image = UIImage(named: destination?.image ?? "")
        }
    }
}
