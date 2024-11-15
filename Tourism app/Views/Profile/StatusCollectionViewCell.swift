//
//  ProfileCollectionViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/5/22.
//

import UIKit
import SDWebImage
class StatusCollectionViewCell: UICollectionViewCell {

   
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    
    @IBOutlet weak var imgView: UIImageView!
        
    
    var cellType: FeedCellType? {
        didSet{
            switch cellType {
            case .userSelf:
                label.isHidden = true
                statusImageView.isHidden = false
            case .other:
                label.isHidden = false
                statusImageView.isHidden = true
            case .none:
                break
            }
        }
    }
    
    var stories: StoriesRow? {
        didSet{
            if stories?.postFiles?.count ?? 0 > 0{
                imgView.sd_setImage(with: URL(string: Route.baseUrl + (stories?.postFiles?[0].imageURL ?? "").replacingOccurrences(of: " ", with: "%20")))
            }
            label.text = stories?.users?.name?.capitalized
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
