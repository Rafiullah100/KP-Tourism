//
//  MyCartTableViewCell.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/3/24.
//

import UIKit

class MyCartTableViewCell: UITableViewCell {

    @IBOutlet weak var vatLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.priceLabel.text = "4.5 \(LocalizationKeys.riyal.rawValue.localizeString())"
        self.vatLabel.text = LocalizationKeys.incVAT.rawValue.localizeString()
    }
    
}
