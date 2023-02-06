//
//  AccomodationDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/8/22.
//

import UIKit
import SDWebImage
class AccomodationDetailViewController: BaseViewController {
  
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var parkingLabel: UILabel!
    @IBOutlet weak var bathLabel: UILabel!
    @IBOutlet weak var bedLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var familyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dropDownImageView: UIImageView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    var accomodationDetail: Accomodation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .backWithTitle
        viewControllerTitle = "\(accomodationDetail?.title ?? "") | Accomodation"
        detailView.isHidden = true
        // Do any additional setup after loading the view.
        
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (accomodationDetail?.thumbnailImage ?? "")))
        nameLabel.text = "\(accomodationDetail?.title ?? "")"
        locationLabel.text = "\(accomodationDetail?.locationTitle ?? "")"
        textView.text = "\(accomodationDetail?.description ?? "")"
//        familyLabel.text = "\(accomodationDetail?.family ?? "")"
        addressLabel.text = "\(accomodationDetail?.locationTitle ?? "")"
//        ratingLabel.text = "\(accomodationDetail?.locationTitle ?? "")"
//        priceLabel.text = "\(accomodationDetail?.priceFrom ?? "")"
        bedLabel.text = "\(accomodationDetail?.noRoom ?? 0)"
    }
    @IBAction func showDetailBtn(_ sender: Any) {
        if detailView.isHidden == true {
            detailView.isHidden = false
            dropDownImageView.image = UIImage(named: "collapse")
        }
        else{
            detailView.isHidden = true
            dropDownImageView.image = UIImage(named: "expand")
        }
    }
}
