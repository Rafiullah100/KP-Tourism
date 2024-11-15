//
//  DestAttractCollectionViewCell.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit

class DestAttractCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var favoriteBtn: UIButton!
    
    @IBOutlet weak var provinceLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var attractionLabel: UILabel!
    var actionBlock: (() -> Void)? = nil

    var attraction: AttractionsDistrict?{
        didSet{
            
            if attraction?.isWished == 1 {
                favoriteBtn.setImage(UIImage(named: "fav"), for: .normal)
            }
            else{
                favoriteBtn.setImage(UIImage(named: "unfavorite-gray"), for: .normal)
            }
            
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (attraction?.previewImage ?? "")))
            attractionLabel.text = attraction?.title
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func likeBtnActio(_ sender: Any) {
        guard UserDefaults.standard.userID != 0, UserDefaults.standard.userID != nil else { return }
        actionBlock?()
    }
}
