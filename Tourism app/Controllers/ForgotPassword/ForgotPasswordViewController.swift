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
        fetch(route: .resetPassword, method: .post, parameters: ["password": new, "confirm_password":confirm, "otp": otp], model: SuccessModel.self)
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let success):
                let res = success as? SuccessModel
                if res?.success == true{
                    self.view.makeToast(res?.message)
                    Switcher.goToLoginVC(delegate: self)
                }
                else{
                    self.view.makeToast(res?.message)
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
}
