//
//  AttractionTableViewCell.swift
//  Tourism app
//
//  Created by Rafi on 19/10/2022.
//

import UIKit

class AttractionTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var pageController: UIPageControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static var cellIdentifier = "cell_identifier"

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favoriteBtnAction(_ sender: Any) {
    }
}
