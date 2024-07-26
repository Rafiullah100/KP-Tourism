//
//  SignupViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/2/22.
//

import UIKit
import SVProgressHUD
import GoogleSignIn

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
    }
    
    @IBAction func signupBtnAction(_ sender: Any) {
        validateSignupFields()
    }
    
    func registerUser(parameters: [String: Any]) {
        dataTask = URLSession.shared.request(route: .registration, method: .post, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    if result.success == true{
                        UserDefaults.standard.otpEmail = self.emailTextField.text
                        Switcher.goToOTPVC(delegate: self)
                    }
                    else{
                        SVProgressHUD.showError(withStatus: result.message)
                    }
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    private func validateSignupFields(){
        guard let email = emailTextField.text, let firstName = firstNameTextFeild.text, !firstName.isEmpty, let password = passwordTextField.text,  let confirmPassword = confirmTextField.text, let phone = phoneTextField.text else { return }
        guard passwordTextField.text?.count ?? 0 >= 6 else {
            self.view.makeToast("Password must be atleast 6 charactors")
            return
        }
        guard passwordTextField.text == confirmTextField.text else {
            self.view.makeToast("Password does not match")
            return }
        let parameters = ["username": email, "name": firstName, "password": password, "confirm_password": confirmPassword, "mobile_no": phone, "user_type": "user"]
        registerUser(parameters: parameters)
    }
    
    @IBAction func gotoLogin(_ sender: Any) {
        Switcher.goToLoginVC(delegate: self)
    }
    
    @IBAction func googleSignInBtn(_ sender: Any) {
        guard let clientID = Constants.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
            if error == nil{
                let parameters = ["username": result?.user.profile?.email ?? "", "user_type": "user", "profile_image": result?.user.profile?.imageURL(withDimension: 120)?.absoluteString ?? "", "name": result?.user.profile?.name ?? ""]
                print(parameters)
                self.loginUser(route: .googleLoginApi, parameters: parameters)
            }
        }
    }
    
    func loginUser(route: Route, parameters: [String: Any]? = nil) {
        dataTask = URLSession.shared.request(route: route, method: .post, parameters: parameters, model: LoginModel.self) { result in
            switch result {
            case .success(let login):
                if login.success == true{
                    UserDefaults.standard.isLoginned = true
                    UserDefaults.standard.accessToken = login.token
                    UserDefaults.standard.userID = login.userID
                    UserDefaults.standard.userEmail = login.email
                    UserDefaults.standard.profileImage = login.profileImage
//                    print(UserDefaults.standard.profileImage, self.login?.profileImage)
                    UserDefaults.standard.name = login.name
                    UserDefaults.standard.uuid = login.uuID
                    UserDefaults.standard.userBio = login.about
                    UserDefaults.standard.loadFirstTime = true
                    UserDefaults.standard.notificationStatus = login.isNotification
                    Helper.shared.changeToDefaultValue()
                    Switcher.goToFeedsVC(delegate: self)
                }
                else{
                    self.view.makeToast(login.message)
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
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
//        let allTextFieldsFilled = !emailTextField.text!.isEmpty && !phoneTextField.text!.isEmpty && !firstNameTextFeild.text!.isEmpty && !passwordTextField.text!.isEmpty && !confirmTextField.text!.isEmpty
//        signupButton.isEnabled = allTextFieldsFilled
    }
}
