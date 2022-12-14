//
//  AboutCollectionViewCell.swift
//  Tourism app
//
//  Created by Rafi on 13/10/2022.
//

import UIKit

class AboutCollectionViewCell: UICollectionViewCell {
    static var cellIdentifier = "cell_identifier"

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var foodLabel: UILabel!
    
    var contact: Contacts? {
        didSet {
            imgView.image = UIImage(named: contact?.photo ?? "")
            foodLabel.text = contact?.department ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
