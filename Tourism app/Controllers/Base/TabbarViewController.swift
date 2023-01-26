//
//  TabbarViewController.swift
//  Tourism app
//
//  Created by Rafi on 03/11/2022.
//

import UIKit

class TabbarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    lazy var homeVC: UIViewController = {
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
    }()
    lazy var alertVC: UIViewController = {
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherAlertViewController")
    }()
    lazy var callVC: UIViewController = {
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CallNowViewController")
    }()
    lazy var loginVC: UIViewController = {
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
    }()
    

    override func viewDidAppear(_ animated: Bool) {
        print("elkrgner")
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 3 {
            var array = self.viewControllers
            array?.remove(at: 3)
            if UserDefaults.standard.isLoginned == true{
                let newsFeedVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "FeedsViewController") as! FeedsViewController
                let navRootVC = UINavigationController.init(rootViewController: newsFeedVC)
                array?.append(navRootVC)
            }
            else{
                let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                let navRootVC = UINavigationController.init(rootViewController: loginVC)
                array?.append(navRootVC)
            }
            self.viewControllers = array
            self.tabBar.items?[3].title = "Login"
            self.tabBar.items?[3].image = UIImage(named: "profile")
        }
    }
}
