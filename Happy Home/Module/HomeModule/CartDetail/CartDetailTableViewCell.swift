//
//  CartDetailTableViewCell.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/3/24.
//

import UIKit

class CartDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var riyalLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        riyalLabel.text = LocalizationKeys.riyal.rawValue.localizeString()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
