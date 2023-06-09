//
//  ThemeSelectionViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/13/23.
//

import UIKit
import GoogleSignIn

class ThemeSelectionViewController: BaseViewController {

    @IBOutlet weak var userParentView: UIView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var switchView: UISwitch!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    var tabbar: TabbarViewController?
    @IBOutlet weak var topLineView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .title1
        viewControllerTitle = "Settings"
//        tabBarController?.delegate = self
        userView.clipsToBounds = true
        userView.layer.cornerRadius = 30
        userView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        userView.viewShadow()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.standard.theme == ThemeMode.dark.rawValue{
            switchView.isOn = true
        }
        else{
            switchView.isOn = false
        }
        
        if UserDefaults.standard.isLoginned == true{
            print(UserDefaults.standard.userType ?? "")
            userParentView.isHidden = false
            topLineView.isHidden = true
            nameLabel.attributedText = Helper.shared.attributedString(text1: UserDefaults.standard.name?.capitalized ?? "", text2: "")
            profileImageView.sd_setImage(with: URL(string: Helper.shared.getProfileImage()))
        }
        else{
            topLineView.isHidden = false
            userParentView.isHidden = true
        }
    }
    
    @IBAction func switchAction(_ sender: Any) {
        if switchView.isOn {
            UIWindow.key?.overrideUserInterfaceStyle = .dark
            UserDefaults.standard.theme = ThemeMode.dark.rawValue
        }
        else{
            UIWindow.key?.overrideUserInterfaceStyle = .light
            UserDefaults.standard.theme = ThemeMode.light.rawValue
        }
    }
    
    @IBAction func linkedinBtnAction(_ sender: Any) {
        if let url = URL(string: "https://twitter.com/kptourism?lang=en") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func instagramBtnAction(_ sender: Any) {
        if let url = URL(string: "https://www.instagram.com/tourisminkp/?utm_source=ig_embed") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func youtubeBtnAction(_ sender: Any) {
        if let url = URL(string: "https://www.youtube.com/channel/UCJJlQUZMDc8SOyxuIMPeJKQ") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func facebookBtnAction(_ sender: Any) {
        if let url = URL(string: "https://www.facebook.com/kptourism/") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func logoutBtnAction(_ sender: Any) {
        GIDSignIn.sharedInstance.signOut()
        Helper.shared.logoutUser(self: self)
    }
    
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        let tabBarIndex = tabBarController.selectedIndex
//        guard tabBarIndex == 4 else {
//            return
//        }
//        if let navigationController = viewController as? UINavigationController {
//            if navigationController.viewControllers.count > 1 {
//                navigationController.popToRootViewController(animated: false)
//            }
//        }
//    }
}



