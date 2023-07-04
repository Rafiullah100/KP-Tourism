//
//  NotificationViewController.swift
//  Tourism app
//
//  Created by Rafi on 15/11/2022.
//

import UIKit
import SVProgressHUD
class NotificationViewController: BaseViewController {


    @IBOutlet weak var switchView: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .notification
        switchView.isOn = UserDefaults.standard.notificationStatus ?? false
    }
    
    @IBAction func switchAction(_ sender: Any) {
        changeNotificationStatus(parameters: ["status": switchView.isOn ? 0 : 1])

    }
    func changeNotificationStatus(parameters: [String: Any]) {
        URLSession.shared.request(route: .notificationSwitchApi, method: .post, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let res):
                if res.success == true {
                    UserDefaults.standard.notificationStatus = !(UserDefaults.standard.notificationStatus ?? false)
                }else{
                    self.switchView.isOn = !self.switchView.isOn
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
}

