//
//  OtpViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 10/29/24.
//

import UIKit

class OtpViewController: UIViewController {

    @IBOutlet weak var changeNumberButton: UIButton!
    @IBOutlet weak var resendButtton: UIButton!
    @IBOutlet weak var didnotRecieveLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var verifyLabel: UILabel!
    @IBOutlet weak var verifyotpLabel: UILabel!
    @IBOutlet weak var verificationCodeLabel: UILabel!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        verificationCodeLabel.text = LocalizationKeys.verificationCodeSentToYourPhone.rawValue.localizeString()
        verifyotpLabel.text = LocalizationKeys.verifyOtp.rawValue.localizeString()
        verifyLabel.text = LocalizationKeys.letQuicklyVerifyYourPhone.rawValue.localizeString()
        verificationCodeLabel.text = LocalizationKeys.verificationCodeSentToYourPhone.rawValue.localizeString()
        didnotRecieveLabel.text = LocalizationKeys.didnotReceiveTheOtp.rawValue.localizeString()
        continueButton.setTitle(LocalizationKeys.Continue.rawValue.localizeString(), for: .normal)
        resendButtton.setTitle(LocalizationKeys.resend.rawValue.localizeString(), for: .normal)
        changeNumberButton.setTitle(LocalizationKeys.changeNumber.rawValue.localizeString(), for: .normal)
    }
    

    @IBAction func dismissButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func continueButtonAction(_ sender: Any) {
        Switcher.gotoUpdateProfile(delegate: self)
    }
    
    @IBAction func resendButtonAction(_ sender: Any) {
    }
    
    @IBAction func changeButtonAction(_ sender: Any) {
    }
}
