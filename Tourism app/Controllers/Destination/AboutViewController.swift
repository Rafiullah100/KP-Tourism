//
//  AboutViewController.swift
//  Tourism app
//
//  Created by Rafi on 13/10/2022.
//

import UIKit
import SDWebImage
class AboutViewController: BaseViewController {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var welcomeLabel: UILabel!

    
//    var contacts: [Contacts]?
    var exploreDistrict: ExploreDistrict?
    var attractionDistrict: AttractionsDistrict?
    var archeology: Archeology?
    var wishlistAttraction: WishlistAttraction?
    var wishlistDistrict: WishlistDistrict?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        if exploreDistrict != nil {
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.thumbnailImage ?? "")))
            thumbnailTopLabel.text = "\(exploreDistrict?.title ?? "")"
            thumbnailBottomLabel.text = "\(exploreDistrict?.locationTitle ?? "")"
            welcomeLabel.text = "Welcome to \(exploreDistrict?.title ?? "")"
            textView.text = exploreDistrict?.description?.htmlToAttributedString
        }
        else if attractionDistrict != nil{
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionDistrict?.displayImage ?? "")))
            thumbnailTopLabel.text = "\(attractionDistrict?.title ?? "")"
            thumbnailBottomLabel.text = "\(attractionDistrict?.locationTitle ?? "")"
            welcomeLabel.text = "Welcome to \(attractionDistrict?.title ?? "")"
            textView.text = attractionDistrict?.description.htmlToAttributedString
        }
        else if archeology != nil{
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (archeology?.attractions.displayImage ?? "")))
            thumbnailTopLabel.text = "\(archeology?.attractions.title ?? "")"
            thumbnailBottomLabel.text = "\(archeology?.attractions.locationTitle ?? "")"
            welcomeLabel.text = "Welcome to \(archeology?.attractions.title ?? "")"
            textView.text = archeology?.attractions.description?.htmlToAttributedString
        }
        else if wishlistDistrict != nil{
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (wishlistDistrict?.previewImage ?? "")))
            thumbnailTopLabel.text = "\(wishlistDistrict?.title ?? "")"
            thumbnailBottomLabel.text = "\(wishlistDistrict?.locationTitle ?? "")"
            welcomeLabel.text = "Welcome to \(wishlistDistrict?.title ?? "")"
            textView.text = wishlistDistrict?.description?.htmlToAttributedString
        }
        else if wishlistAttraction != nil{
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (wishlistAttraction?.previewImage ?? "")))
            thumbnailTopLabel.text = "\(wishlistAttraction?.title ?? "")"
            thumbnailBottomLabel.text = "\(wishlistAttraction?.locationTitle ?? "")"
            welcomeLabel.text = "Welcome to \(wishlistAttraction?.title ?? "")"
            textView.text = wishlistAttraction?.description?.htmlToAttributedString
        }
    }
    
    
    @IBAction func callBtnAction(_ sender: Any) {
        let url: NSURL = URL(string: Constants.helpline)! as NSURL
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)    }
}






