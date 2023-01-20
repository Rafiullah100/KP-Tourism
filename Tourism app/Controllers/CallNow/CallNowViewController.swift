//
//  CallNowViewController.swift
//  Tourism app
//
//  Created by Rafi on 11/11/2022.
//

import UIKit
import SwiftGifOrigin
class CallNowViewController: BaseViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .title
        viewControllerTitle = "Tourism Emergency Helpline"
        imageView.loadGif(name: "call-icon")
    }

    @IBAction func callnowBtn(_ sender: Any) {
        let url: NSURL = URL(string: "TEL://1422")! as NSURL
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
}
