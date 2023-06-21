//
//  NotificationViewController.swift
//  Tourism app
//
//  Created by Rafi on 15/11/2022.
//

import UIKit
import SVProgressHUD
class NotificationViewController: BaseViewController {

    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .notification
        yesButton.isEnabled = true
        yesButton.isUserInteractionEnabled = true
    }
    
    @IBAction func yesnotifyBtn(_ sender: Any) {
        changeNotificationStatus(parameters: ["status": 1])
    }
    
    @IBAction func skipBtn(_ sender: Any) {
        changeNotificationStatus(parameters: ["status": 0])
    }
    
    func changeNotificationStatus(parameters: [String: Any]) {
        URLSession.shared.request(route: .notificationSwitchApi, method: .post, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let success):
                let model = success
                self.view.makeToast(model.message)
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
}

