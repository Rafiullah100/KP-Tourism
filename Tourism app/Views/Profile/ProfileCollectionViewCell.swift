//
//  ProfileCollectionViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/7/22.
//

import UIKit
import SDWebImage
class ProfileCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var label: UILabel!
    var post: UserPostRow? {
        didSet {
            if post?.postFiles?.count ?? 0 > 0{
                imgView.sd_setImage(with: URL(string: Route.baseUrl + (post?.postFiles?[0].imageURL ?? "")))
            }
        }
    }
    
    var editActionBlock: (() -> Void)? = nil
    var deleteActionBlock: (() -> Void)? = nil

    
    var product: UserProductRow? {
        didSet {
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (product?.previewImage ?? "")))
        }
    }
//
    var blog: UserBlogRow? {
        didSet {
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (blog?.previewImage ?? "") ))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func deleteBtnAction(_ sender: Any) {
        deleteActionBlock?()
    }
    @IBAction func editBtnAction(_ sender: Any) {
        editActionBlock?()
    }
}
