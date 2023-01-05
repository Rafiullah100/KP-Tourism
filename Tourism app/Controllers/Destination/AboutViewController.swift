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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        
        thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.thumbnailImage ?? "")))
        thumbnailBottomLabel.text = "\(exploreDistrict?.title ?? "")"
        welcomeLabel.text = "Welcome to \(exploreDistrict?.title ?? "")"
        textView.text = "\(exploreDistrict?.description ?? "")"
    }
}






