//
//  ForgotPasswordViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/27/23.
//

import UIKit
import SVProgressHUD
class ForgotPasswordViewController: BaseViewController {

    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .title
        viewControllerTitle = "Forgot Password"
    }

    @IBAction func resetPasswordBtn(_ sender: Any) {
        guard let new = newPasswordTF.text, let confirm = confirmPasswordTF.text, let otp = otpTextField.text, !new.isEmpty, !confirm.isEmpty, !otp.isEmpty else {
            self.view.makeToast("Fill all fields.")
            SVProgressHUD.setDefaultMaskType(.none)
            return  }
        fetch(parameters: ["password": new, "confirm_password":confirm, "otp": otp])
    }
    
    func fetch(parameters: [String: Any]) {
        dataTask = URLSession.shared.request(route: .resetPassword, method: .post, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let success):
                if success.success == true{
                    self.view.makeToast(success.message)
                    Switcher.goToLoginVC(delegate: self)
                }
                else{
                    self.view.makeToast(success.message)
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
}
