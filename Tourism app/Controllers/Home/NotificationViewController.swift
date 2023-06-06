//
//  NotificationViewController.swift
//  Tourism app
//
//  Created by Rafi on 15/11/2022.
//

import UIKit
import SVProgressHUD
class NotificationViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        type = .notification
    }
    
    @IBAction func yesnotifyBtn(_ sender: Any) {
        changeNotificationStatus(route: .notificationSwitchApi, method: .post, parameters: ["status": 1], model: SuccessModel.self)
    }
    
    @IBAction func skipBtn(_ sender: Any) {
        changeNotificationStatus(route: .notificationSwitchApi, method: .post, parameters: ["status": 0], model: SuccessModel.self)
    }
    
    func changeNotificationStatus<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let success):
                let model = success as! SuccessModel
                self.view.makeToast(model.message)
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
}

