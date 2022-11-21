//
//  AttractionTableViewCell.swift
//  Tourism app
//
//  Created by Rafi on 19/10/2022.
//

import UIKit
import ImageSlideshow
class AttractionTableViewCell: UITableViewCell {

    
    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    var delegate: Dragged?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static func configureCell() {
        //
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favoriteBtnAction(_ sender: Any) {
    }
}
