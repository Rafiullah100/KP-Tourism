//
//  SplashScreenViewController.swift
//  Tourism app
//
//  Created by Rafi on 03/11/2022.
//

import UIKit
import SwiftGifOrigin
class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            Switcher.goToTabbar(delegate: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let imageView: UIImageView = view.viewWithTag(101) as! UIImageView
        imageView.image = UIImage.gif(name: "logo")
    }
}

