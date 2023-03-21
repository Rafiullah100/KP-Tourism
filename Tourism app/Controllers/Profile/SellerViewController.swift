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
    
    var userType = "user"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBarView.addBottomShadow()
        if UserDefaults.standard.userType == "seller"{
            switchView.setOn(true, animated: true)
        }
        else{
            switchView.setOn(false, animated: true)
        }
    }
    
    @IBAction func switchUser(_ sender: Any) {
        if switchView.isOn{
            userType = "seller"
        }
        else{
            userType = "user"
        }
        
        changeUserType(route: .sellerTypeAPI, method: .post, parameters: ["type": userType], model: SuccessModel.self)
    }
    
    func changeUserType<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let change):
                if (change as! SuccessModel).success == true{
                    print(change as! SuccessModel)
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
