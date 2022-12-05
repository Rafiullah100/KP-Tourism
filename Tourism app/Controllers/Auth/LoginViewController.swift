//
//  LoginViewController.swift
//  Tourism app
//
//  Created by Rafi on 27/10/2022.
//

import UIKit

class LoginViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .title
        viewControllerTitle = "Login"
    }

    @IBAction func gotoSignUp(_ sender: Any) {
        Switcher.goToSignupVC(delegate: self)
    }
    
    @IBAction func LoginBtnAction(_ sender: Any) {
        Switcher.goToFeedsVC(delegate: self)
    }
}
