//
//  SellerViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/12/22.
//

import UIKit
import SVProgressHUD
class SellerViewController: UIViewController {
   
    @IBOutlet weak var switchView: UISwitch!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var navigationLabel: UILabel!
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var type = "user"
    var userType: UserType?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBarView.addBottomShadow()
        
        if userType == .seller{
            navigationLabel.text = "Become Seller"
            switchLabel.text = "Switch to Seller Mode"
            descriptionLabel.text = "KP has a unique selection of local products. As a registered seller, you can buy or sell your own local products."
            switchView.setOn(UserDefaults.standard.isSeller == "approved" ? true : false, animated: true)
        }
        else if userType == .tourist{
            navigationLabel.text = "Become Tourist"
            switchLabel.text = "Switch to Tourist Mode"
            descriptionLabel.text = ""
            switchView.setOn(UserDefaults.standard.isTourist == "approved" ? true : false, animated: true)
        }
    }
    
    @IBAction func switchUser(_ sender: Any) {
        if userType == .seller{
            type = switchView.isOn == true ? "seller" : UserDefaults.standard.userType ?? ""
        }
        else if userType == .tourist{
            type = switchView.isOn == true ? "tourist" : UserDefaults.standard.userType ?? ""
        }
        changeUserType(parameters: ["type": type])
    }
    
    func changeUserType(parameters: [String: Any]) {
        URLSession.shared.request(route: .userTypeAPI, method: .post, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let res):
                if res.success == true{
                    self.view.makeToast(res.message)
                }
                else{
                    self.view.makeToast(res.message)
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
