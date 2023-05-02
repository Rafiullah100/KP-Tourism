//
//  SignupViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/2/22.
//

import UIKit
import SVProgressHUD
class SignupViewController: BaseViewController {
    
    let pickerView = UIPickerView()
    let userType = ["Tourist", "Seller"]
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextFeild: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userTypeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.hidesBackButton = true
        type = .title
        viewControllerTitle = "Sign up"
        userTypeTextField.inputView = pickerView
        userTypeTextField.text = userType[0]
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @IBAction func signupBtnAction(_ sender: Any) {
        validateSignupFields()
    }
    
    func registerUser<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    let res = result as! SuccessModel
                    if res.success == true{
                        UserDefaults.standard.otpEmail = self.emailTextField.text
                        Switcher.goToOTPVC(delegate: self)
                    }
                    else{
                        SVProgressHUD.showError(withStatus: res.message)
                    }
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    private func validateSignupFields(){
        guard let email = emailTextField.text, let firstName = firstNameTextFeild.text, let lastName = lastNameTextField.text, let password = passwordTextField.text, let confirmPassword = confirmTextField.text, let phone = phoneTextField.text else { return }
        guard passwordTextField.text == confirmTextField.text else { return }
        let parameters = ["username": email, "name": firstName + " " + lastName, "password": password, "confirm_password": confirmPassword, "mobile_no": phone, "user_type": "user"]
        registerUser(route: .registration, method: .post, parameters: parameters, model: SuccessModel.self)
    }
    
    @IBAction func gotoLogin(_ sender: Any) {
        Switcher.goToLoginVC(delegate: self)
    }
}

extension SignupViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        userType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userTypeTextField.text = userType[row]
    }
}
