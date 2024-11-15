//
//  LoginViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 10/29/24.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var privacyButton: UIButton!
    
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var forgotPhoneButton: UIButton!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var signinLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        signinLabel.text = LocalizationKeys.signin.rawValue.localizeString()
        numberTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        signinButton.setTitle(LocalizationKeys.signin.rawValue.localizeString(), for: .normal)
        forgotPhoneButton.setTitle(LocalizationKeys.forgotPhone.rawValue.localizeString(), for: .normal)
        privacyButton.setTitle(LocalizationKeys.termsAndConditions.rawValue.localizeString(), for: .normal)
    }
    

    @IBAction func signinButtonAction(_ sender: Any) {
        Switcher.gotoOtpScreen(delegate: self)
    }
}
