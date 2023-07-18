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
    @IBOutlet weak var deleteView: UIView!
    var profileType: ProfileType?
    var sectionType: ProfileSection?
    
    var post: UserPostRow? {
        didSet {
            label.text = post?.description
            if post?.postFiles?.count ?? 0 > 0{
                imgView.sd_setImage(with: URL(string: Route.baseUrl + (post?.postFiles?[0].imageURL ?? "")))
                hideButtons()
            }
        }
    }
    
    var editActionBlock: (() -> Void)? = nil
    var deleteActionBlock: (() -> Void)? = nil
        
    
    @IBOutlet weak var editView: UIView!
    var product: UserProductRow? {
        didSet {
            label.text = product?.title
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (product?.previewImage ?? "")))
            hideButtons()
        }
    }
    var blog: UserBlogRow? {
        didSet {
            label.text = blog?.title
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (blog?.previewImage ?? "") ))
            hideButtons()
        }
    }
    
    var tourPackage: UserProfileTourPackages? {
        didSet {
            label.text = tourPackage?.title
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (tourPackage?.preview_image ?? "")))
            hideButtons()
        }
    }
    
//    var profileType: ProfileType? {
//        didSet{
//            if profileType == .user{
//                hideButtons(isHidden: false)
//            }
//            else if profileType == .otherUser{
//                hideButtons(isHidden: true)
//            }
//        }
//    }
//
//    var sectionType: ProfileSection? {
//        didSet{
//            if sectionType == .post{
//                hideButtons(isHidden: true)
//            }
//            else{
//                hideButtons(isHidden: false)
//            }
//        }
//    }
    
    func hideButtons() {
        print(isHidden)
        if profileType == .otherUser {
            deleteView.isHidden = true
            editView.isHidden = true
        }
        else{
            if sectionType == .post {
                deleteView.isHidden = true
                editView.isHidden = true
            }
            else{
                deleteView.isHidden = false
                editView.isHidden = false
            }
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
