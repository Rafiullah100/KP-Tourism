//
//  OtpViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 10/29/24.
//

import UIKit

class OtpViewController: UIViewController {

    @IBOutlet weak var verificationCodeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        verificationCodeLabel.text = "Verification Code sent to your \nPhone ********89"
    }
    

    @IBAction func dismissButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func continueButtonAction(_ sender: Any) {
        Switcher.gotoUpdateProfile(delegate: self)
    }
}
