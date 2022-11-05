//
//  AccomodationTableViewCell.swift
//  Tourism app
//
//  Created by Rafi on 13/10/2022.
//

import UIKit

class AccomodationTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    static var celldentifier = "cell_identifier"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
