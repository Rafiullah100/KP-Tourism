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
//    lazy var alertVC: UIViewController = {
//        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherAlertViewController")
//    }()
//    lazy var callVC: UIViewController = {
//        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CallNowViewController")
//    }()
    lazy var loginVC: UIViewController = {
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
    }()
    

    override func viewDidAppear(_ animated: Bool) {
        self.viewControllers?[Constants.tab].title = UserDefaults.standard.isLoginned == true ? "Profile" : "Login"
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        var name = ""
        
        if tabBarIndex == Constants.tab {
            var array = self.viewControllers
            array?.remove(at: Constants.tab)
            if UserDefaults.standard.isLoginned == true{
                guard UserDefaults.standard.loadFirstTime == true else {
                    return
                }
                UserDefaults.standard.loadFirstTime = false
                let newsFeedVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "FeedsViewController") as! FeedsViewController
                let navRootVC = UINavigationController.init(rootViewController: newsFeedVC)
                name = Helper.shared.changeTab(isLoggined: true)
                array?.insert(navRootVC, at: Constants.tab)
            }
            else{
                let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                let navRootVC = UINavigationController.init(rootViewController: loginVC)
                name = Helper.shared.changeTab(isLoggined: false)
                array?.insert(navRootVC, at: Constants.tab)
            }
            self.viewControllers = array
            self.tabBar.items?[Constants.tab].title = name
            self.tabBar.items?[Constants.tab].image = UIImage(named: "profile")
        }
    }
}
