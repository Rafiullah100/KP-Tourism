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
    
    @IBOutlet weak var loginButton: UIButton!
    var login: LoginModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .title1
        viewControllerTitle = "Login"
        //tourist
        emailTextField.text = "murtazakhan68@gmail.com"
        passwordTextField.text = "12345678"
        
//        //seller
        emailTextField.text = "rafiseller@gmail.com"
        passwordTextField.text = "123"
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func googleSigninBtn(_ sender: Any) {
        guard let clientID = Constants.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
            if error == nil{
                let parameters = ["username": result?.user.profile?.email ?? "", "user_type": "user", "profile_image": result?.user.profile?.imageURL(withDimension: 120)?.absoluteString ?? ""]
                self.loginUser(route: .googleLoginApi, parameters: parameters)
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
                    self.loginUser(route: .facebookLoginApi, parameters: ["username": email, "profile_image": url, "user_type": "user"])
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
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty  else {
            self.view.makeToast("Enter all fields.")
            return }
        let parameters = ["username": email, "password": password]
        loginUser(route: .login, parameters: parameters)
    }
    
    func loginUser(route: Route, parameters: [String: Any]? = nil) {
        dataTask = URLSession.shared.request(route: route, method: .post, parameters: parameters, model: LoginModel.self) { result in
            switch result {
            case .success(let login):
                self.login = login
                if self.login?.success == true{
                    UserDefaults.standard.isLoginned = true
                    UserDefaults.standard.accessToken = self.login?.token
                    UserDefaults.standard.userID = self.login?.userID
                    UserDefaults.standard.userEmail = self.login?.email
                    UserDefaults.standard.profileImage = self.login?.profileImage
                    UserDefaults.standard.name = self.login?.name
                    UserDefaults.standard.uuid = self.login?.uuID
                    UserDefaults.standard.userBio = self.login?.about
                    UserDefaults.standard.loadFirstTime = true
                    UserDefaults.standard.notificationStatus = self.login?.isNotification
                    Helper.shared.changeToDefaultValue()
                    Switcher.goToFeedsVC(delegate: self)
                }
                else{
                    self.view.makeToast(self.login?.message)
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
}
