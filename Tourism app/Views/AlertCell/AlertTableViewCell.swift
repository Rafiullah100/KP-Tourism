//
//  AlertTableViewCell.swift
//  Tourism app
//
//  Created by Rafi on 13/11/2022.
//

import UIKit

class AlertTableViewCell: UITableViewCell {
    static let cellIdentifier = "cell_identifier"

    @IBOutlet weak var isSafeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var warning: Warning? {
        didSet{
            titleLabel.text = warning?.title
            descriptionLabel.text = warning?.description
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
