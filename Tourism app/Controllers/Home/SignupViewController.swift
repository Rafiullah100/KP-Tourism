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
    
    @IBOutlet weak var phoneTextField: UITextField!{
        didSet{
            self.phoneTextField.delegate = self
        }
    }
    @IBOutlet weak var confirmTextField: UITextField!{
        didSet{
            self.confirmTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: UITextField!{
        didSet{
            self.passwordTextField.delegate = self
        }
    }
    @IBOutlet weak var lastNameTextField: UITextField!{
        didSet{
            self.lastNameTextField.delegate = self
        }
    }
    
    @IBOutlet weak var firstNameTextFeild: UITextField!{
        didSet{
            self.firstNameTextFeild.delegate = self
        }
    }
    @IBOutlet weak var emailTextField: UITextField!{
        didSet{
            self.emailTextField.delegate = self
        }
    }
    @IBOutlet weak var userTypeTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.hidesBackButton = true
        type = .title
        viewControllerTitle = "Sign up"
        userTypeTextField.inputView = pickerView
        userTypeTextField.text = Constants.userType[0]
        pickerView.delegate = self
        pickerView.dataSource = self
        signupButton.isEnabled = false
    }
    
    @IBAction func signupBtnAction(_ sender: Any) {
        validateSignupFields()
    }
    
    func registerUser(parameters: [String: Any]) {
        URLSession.shared.request(route: .registration, method: .post, parameters: parameters, model: SuccessModel.self) { result in
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
        guard let email = emailTextField.text, let firstName = firstNameTextFeild.text, !firstName.isEmpty, let password = passwordTextField.text,  let confirmPassword = confirmTextField.text, let phone = phoneTextField.text else { return }
        guard passwordTextField.text == confirmTextField.text else {
            self.view.makeToast("Password does not match")
            return }
        let parameters = ["username": email, "name": firstName, "password": password, "confirm_password": confirmPassword, "mobile_no": phone, "user_type": "user"]
        registerUser(parameters: parameters)
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
        Constants.userType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Constants.userType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userTypeTextField.text = Constants.userType[row]
    }
}

extension SignupViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let allTextFieldsFilled = !emailTextField.text!.isEmpty && !phoneTextField.text!.isEmpty && !firstNameTextFeild.text!.isEmpty && !passwordTextField.text!.isEmpty && !confirmTextField.text!.isEmpty
        signupButton.isEnabled = allTextFieldsFilled
    }
}
