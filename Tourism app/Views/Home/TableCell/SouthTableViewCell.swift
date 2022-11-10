//
//  SouthTableViewCell.swift
//  Tourism app
//
//  Created by Rafi on 19/10/2022.
//

import UIKit

class SouthTableViewCell: UITableViewCell {
    static var cellIdentifier = "cell_identifier"

    @IBOutlet weak var pageController: UIPageControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
