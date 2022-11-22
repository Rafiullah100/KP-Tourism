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
    let localSource = [BundleImageSource(imageString: "Mask Group 4"), BundleImageSource(imageString: "Mask Group 5"), BundleImageSource(imageString: "Mask Group 14")]

    override func awakeFromNib() {
        super.awakeFromNib()
        slideShow.slideshowInterval = 2.0
        slideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
        slideShow.isUserInteractionEnabled = false
        slideShow.setImageInputs(localSource)
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
