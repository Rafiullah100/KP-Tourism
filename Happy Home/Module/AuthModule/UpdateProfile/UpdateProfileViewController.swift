//
//  UpdateProfileViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/10/24.
//

import UIKit

class UpdateProfileViewController: UIViewController {

    @IBOutlet weak var privacyLabel: UILabel!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var approveLabel: UILabel!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var updateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        approveLabel.text = LocalizationKeys.approve.rawValue.localizeString()
        emailTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        locationTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        nameTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        nameTextField.placeholder = LocalizationKeys.fullName.rawValue.localizeString()
        emailTextField.placeholder = LocalizationKeys.email.rawValue.localizeString()
        locationTextField.text = LocalizationKeys.addLocation.rawValue.localizeString()
        privacyLabel.text = LocalizationKeys.privacyPolicy.rawValue.localizeString()
        approveLabel.text = LocalizationKeys.approve.rawValue.localizeString()
        termsLabel.text = LocalizationKeys.termsAndConditions.rawValue.localizeString()

        continueButton.setTitle(LocalizationKeys.signin.rawValue.localizeString(), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func continueButtonAction(_ sender: Any) {
        Switcher.gotoHome(delegate: self)
    }
    
}
