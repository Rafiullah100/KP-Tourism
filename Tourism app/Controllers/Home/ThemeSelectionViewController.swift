//
//  ThemeSelectionViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/13/23.
//

import UIKit

class ThemeSelectionViewController: BaseViewController, UITabBarControllerDelegate {

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
        
        userView.clipsToBounds = true
        userView.layer.cornerRadius = 30
        userView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        userView.viewShadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.theme == ThemeMode.dark.rawValue{
            switchView.isOn = true
        }
        else{
            switchView.isOn = false
        }
        
        if UserDefaults.standard.isLoginned == true{
            userParentView.isHidden = false
            topLineView.isHidden = true
            nameLabel.text = UserDefaults.standard.name?.capitalized
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
    
    @IBAction func logoutBtnAction(_ sender: Any) {
        UserDefaults.clean()
        Switcher.goToLoginVC(delegate: self)
    }
}
