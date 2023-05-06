//
//  LoginViewController.swift
//  Tourism app
//
//  Created by Rafi on 27/10/2022.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn
import Firebase
import Toast_Swift
import SVProgressHUD
class LoginViewController: BaseViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var login: LoginModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .title1
//        emailTextField.text = "arsalan@gmail.com"
//        passwordTextField.text = "123456"
        viewControllerTitle = "Login"
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = true
//        self.navigationController?.navigationItem.hidesBackButton = true
    }

    @IBAction func googleSigninBtn(_ sender: Any) {
        guard let clientID = Constants.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
         GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
            if error == nil{
                let parameters = ["username": result?.user.profile?.email ?? "", "profile_image": result?.user.profile?.imageURL(withDimension: 120)?.absoluteString ?? ""]
                self.loginUser(route: .googleLoginApi, method: .post, parameters: parameters, model: LoginModel.self)
            }
        }
    }
    
    @IBAction func fbLoginBtnAction(_ sender: Any) {
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : LoginManagerLoginResult = result!
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                }
            }
        }
    }
    
    func getFBUserData(){
        guard let token = AccessToken.current?.tokenString else { return }
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email, picture"], tokenString: token, version: nil, httpMethod: .get)
        request.start{ (connection, result, error) in
            if error == nil{
                guard let json = result as? NSDictionary else { return }
                if let email = json["email"] as? String, let picture = json["picture"] as? NSDictionary, let data = picture["data"] as? NSDictionary, let url = data["url"] as? String{
                    self.loginUser(route: .facebookLoginApi, method: .post, parameters: ["username": email, "profile_image": url], model: LoginModel.self)
                }
            }
        }
    }
    
    @IBAction func gotoSignUp(_ sender: Any) {
        Switcher.goToSignupVC(delegate: self)
    }
    
    @IBAction func forgotPasswordBtn(_ sender: Any) {
        Switcher.gotoEmailVC(delegate: self)
//        Switcher.goToOTPVC(delegate: self)
    }
    
    @IBAction func LoginBtnAction(_ sender: Any) {
        validateLoginFields()
    }
    
    func loginUser<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let login):
                self.login = login as? LoginModel
                if self.login?.success == true{
                    UserDefaults.standard.isLoginned = true
                    UserDefaults.standard.accessToken = self.login?.token
                    UserDefaults.standard.userID = self.login?.userID
                    UserDefaults.standard.userEmail = self.login?.email
                    UserDefaults.standard.profileImage = self.login?.profileImage
                    UserDefaults.standard.name = self.login?.name
                    UserDefaults.standard.uuid = self.login?.uuID
                    UserDefaults.standard.userBio = self.login?.about
                    Switcher.goToFeedsVC(delegate: self)
                }
                else{
                    SVProgressHUD.showError(withStatus: self.login?.message)
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    private func validateLoginFields(){
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            self.view.makeToast("All fields are required.", duration: 3.0, position: .center)
            return }
        guard passwordTextField.text == passwordTextField.text else {
            self.view.makeToast("Password doesn't match.", duration: 3.0, position: .top)
            return }
        let parameters = ["username": email, "password": password]
        loginUser(route: .login, method: .post, parameters: parameters, model: LoginModel.self)
    }
    
    private func changeTabbar(){
//        tabBarController?.setViewControllers(<#T##viewControllers: [UIViewController]?##[UIViewController]?#>, animated: <#T##Bool#>)
    }
}
