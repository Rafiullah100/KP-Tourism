//
//  PreferrencesTableViewCell.swift
//  HappyHome
//
//  Created by NGEN on 31/10/2024.
//

import UIKit

class PreferrencesTableViewCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        iconView.image = UIImage(named: Helper.shared.isRTL() ? "ar-Right-arrow" : "Right-arrow")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func displaySettings(data: settingData)  {
        lbl.text = data.text
        img.image = UIImage(named: data.icon!)
    }
}
