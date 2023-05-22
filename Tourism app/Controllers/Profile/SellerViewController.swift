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
    
    var type = "user"
    var userType: UserType?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBarView.addBottomShadow()
        if userType == .seller{
            if UserDefaults.standard.isSeller == "approved"{
                switchView.setOn(true, animated: true)
            }
            else{
                switchView.setOn(false, animated: true)
            }
        }
        else if userType == .tourist{
            if UserDefaults.standard.isTourist == "approved"{
                switchView.setOn(true, animated: true)
            }
            else{
                switchView.setOn(false, animated: true)
            }
        }
    }
    
    @IBAction func switchUser(_ sender: Any) {
        if userType == .seller{
            if switchView.isOn{
                type = "seller"
            }
            else{
                type = UserDefaults.standard.userType ?? ""
            }
        }
        else if userType == .tourist{
            if switchView.isOn{
                type = "tourist"
            }
            else{
                type = UserDefaults.standard.userType ?? ""
            }
        }
        changeUserType(route: .userTypeAPI, method: .post, parameters: ["type": type], model: SuccessModel.self)
    }
    
    func changeUserType<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let change):
                let res = change as? SuccessModel
                if res?.success == true{
                    SVProgressHUD.showSuccess(withStatus: res?.message)
                }
                else{
                    SVProgressHUD.showError(withStatus: res?.message)
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
