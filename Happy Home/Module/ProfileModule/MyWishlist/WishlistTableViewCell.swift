//
//  WishlistTableViewCell.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/9/24.
//

import UIKit

class WishlistTableViewCell: UITableViewCell {

    @IBOutlet weak var vatLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vatLabel.text = LocalizationKeys.incVAT.rawValue.localizeString()
        priceLabel.text = "4.5 \(LocalizationKeys.riyal.rawValue.localizeString())"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
