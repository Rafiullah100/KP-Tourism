//
//  EventTableViewCell.swift
//  Tourism app
//
//  Created by Rafi on 17/11/2022.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    static var cellIdentifier = "cell_identifier"

    @IBOutlet weak var statusView: UIView!
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
