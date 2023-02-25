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
class LoginViewController: BaseViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var login: LoginModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationItem.hidesBackButton = true
        type = .title
        emailTextField.text = "arsalan@gmail.com"
        passwordTextField.text = "1234567"
        viewControllerTitle = "Login"
    }

    @IBAction func googleSigninBtn(_ sender: Any) {
        guard let clientID = Constants.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: Helper.shared.rootVC()) { result, error in
            if error == nil{
                print(result?.user.profile?.email ?? "")
            }
        }
    }
    
    @IBAction func fbLoginBtnAction(_ sender: Any) {
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) -> Void in
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
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email"], tokenString: token, version: nil, httpMethod: .get)
        request.start{ (connection, result, error) in
            if error == nil{
                guard let json = result as? NSDictionary else { return }
                if let email = json["email"] as? String {
                    print("\(email)")
                }
            }
        }
    }
    
    @IBAction func gotoSignUp(_ sender: Any) {
        Switcher.goToSignupVC(delegate: self)
    }
    
    @IBAction func LoginBtnAction(_ sender: Any) {
        validateLoginFields()
    }
    
    func loginUser<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let login):
                DispatchQueue.main.async {
                    self.login = login as? LoginModel
                    if self.login?.success == true{
                        UserDefaults.standard.isLoginned = true
                        UserDefaults.standard.accessToken = self.login?.token
                        UserDefaults.standard.userID = self.login?.userID
                        UserDefaults.standard.userEmail = self.login?.email
                        Switcher.goToFeedsVC(delegate: self)
                    }
                    else{
                        //show alert
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func validateLoginFields(){
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        guard passwordTextField.text == passwordTextField.text else { return }
        let parameters = ["username": email, "password": password]
        print(parameters)
        loginUser(route: .login, method: .post, parameters: parameters, model: LoginModel.self)
    }
    
    private func changeTabbar(){
//        tabBarController?.setViewControllers(<#T##viewControllers: [UIViewController]?##[UIViewController]?#>, animated: <#T##Bool#>)
    }
}
