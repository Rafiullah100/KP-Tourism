//
//  SecurityViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/12/22.
//

import UIKit
import SVProgressHUD
class SecurityViewController: BaseViewController {
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
        changePassword(parameters: ["old_password": oldPassword, "password": newPassword, "confirm_password": confirmPassword])
    }
    
    func changePassword(parameters: [String: Any]) {
        dataTask = URLSession.shared.request(route: .changePassword, method: .post, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let change):
                if change.success == true{
                    self.oldPasswordTF.text = ""
                    self.newPasswordTF.text = ""
                    self.confirmPasswordTF.text = ""
                }
                self.view.makeToast(change.message)
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }

    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
