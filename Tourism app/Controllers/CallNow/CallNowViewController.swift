//
//  CallNowViewController.swift
//  Tourism app
//
//  Created by Rafi on 11/11/2022.
//

import UIKit

class CallNowViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .title
        viewControllerTitle = "Tourism Emergency Helpline"
    }

    @IBAction func callnowBtn(_ sender: Any) {
        let url: NSURL = URL(string: "TEL://1422")! as NSURL
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
}
