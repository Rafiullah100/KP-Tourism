//
//  EmailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/27/23.
//

import UIKit
import SVProgressHUD
class EmailViewController: BaseViewController {

    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .title
        viewControllerTitle = "Forgot Password"
    }
    
    
    
    @IBAction func continueBtnAction(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty else { return }
        fetch(parameters: ["email": email])
    }
    
    func fetch(parameters: [String: Any]) {
        URLSession.shared.request(route: .forgotPasswordApi, method: .post, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let success):
                if success.success == true{
                    self.view.makeToast(success.message)
                    Switcher.gotoForgotPassword(delegate: self)
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
