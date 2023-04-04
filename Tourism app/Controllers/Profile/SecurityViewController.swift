//
//  SecurityViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/12/22.
//

import UIKit
import SVProgressHUD
class SecurityViewController: UIViewController {
    @IBOutlet weak var topBarView: UIView!

    @IBOutlet weak var oldPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    
    @IBOutlet weak var confirmPasswordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        topBarView.addBottomShadow()
        oldPasswordTF.useUnderline()
        newPasswordTF.useUnderline()
        confirmPasswordTF.useUnderline()
    }
    
    @IBAction func updatePWBtnAction(_ sender: Any) {
        guard let oldPassword = oldPasswordTF.text, let newPassword = newPasswordTF.text, let confirmPassword = confirmPasswordTF.text, !oldPassword.isEmpty, !oldPassword.isEmpty, !confirmPassword.isEmpty  else {
            self.view.makeToast("All fields are required.", duration: 3.0, position: .center)
            return }
        
        guard newPassword == confirmPassword else {
            self.view.makeToast("Passwords doesn't match.", duration: 3.0, position: .center)
            return }
        changePassword(route: .changePassword, method: .post, parameters: ["old_password": oldPassword, "password": newPassword, "confirm_password": confirmPassword], model: SuccessModel.self)
    }
    
    func changePassword<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let change):
                if (change as! SuccessModel).success == true{
                    self.oldPasswordTF.text = ""
                    self.newPasswordTF.text = ""
                    self.confirmPasswordTF.text = ""
                }
                SVProgressHUD.showSuccess(withStatus: (change as! SuccessModel).message)
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }

    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
