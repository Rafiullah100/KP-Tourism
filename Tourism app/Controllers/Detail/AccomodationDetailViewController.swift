//
//  AccomodationDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/8/22.
//

import UIKit

class AccomodationDetailViewController: BaseViewController {
  
    @IBOutlet weak var dropDownImageView: UIImageView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .backWithTitle
        viewControllerTitle = "T-NEE Hotel | Accomodation"
        detailView.isHidden = true
        // Do any additional setup after loading the view.
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
