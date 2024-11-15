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
        fetch(route: .forgotPasswordApi, method: .post, parameters: ["email": email], model: SuccessModel.self)
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let success):
                let res = success as? SuccessModel
                if res?.success == true{
                    SVProgressHUD.showSuccess(withStatus: res?.message)
                    Switcher.gotoForgotPassword(delegate: self)
                }
                else{
                    SVProgressHUD.showError(withStatus: res?.message)
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
}
