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

    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        if exploreDistrict != nil {
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.thumbnailImage ?? "")))
            thumbnailTopLabel.text = "\(exploreDistrict?.title ?? "")"
            thumbnailBottomLabel.text = "\(exploreDistrict?.locationTitle ?? "")"
            welcomeLabel.text = "Welcome to \(exploreDistrict?.title ?? "")"
            textView.text = "\(exploreDistrict?.description?.stripOutHtml() ?? "")"
        }
        else if attractionDistrict != nil{
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionDistrict?.displayImage ?? "")))
            thumbnailTopLabel.text = "\(exploreDistrict?.title ?? "")"
            thumbnailBottomLabel.text = "\(attractionDistrict?.locationTitle ?? "")"
            welcomeLabel.text = "Welcome to \(attractionDistrict?.title ?? "")"
            textView.text = "\(attractionDistrict?.description.stripOutHtml() ?? "")"
        }
        else if archeology != nil{
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (archeology?.image_url ?? "")))
            thumbnailTopLabel.text = "\(archeology?.attractions?.title ?? "")"
            thumbnailBottomLabel.text = "\(attractionDistrict?.locationTitle ?? "")"
            welcomeLabel.text = "Welcome to \(archeology?.attractions?.title ?? "")"
            textView.text = "\(archeology?.attractions?.description?.stripOutHtml() ?? "")"
        }
    }
    
    
    @IBAction func callBtnAction(_ sender: Any) {
        let url: NSURL = URL(string: "TEL://1422")! as NSURL
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }

}






