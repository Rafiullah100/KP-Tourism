//
//  NotificationListViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 5/17/23.
//

import UIKit
import SVProgressHUD
class NotificationTableViewCell: UITableViewCell {
    let cell_identifier = ""
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    var notification: NotificationsRow? {
        didSet{
            bgView.viewShadow()
            titleLabel.text = notification?.title
            descriptionLabel.text = notification?.description
            dateLabel.text = notification?.createdAt
        }
    }
}

class NotificationListViewController: BaseViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var notifications: [NotificationsRow] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.viewShadow()
        fetchNotification()
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func fetchNotification() {
        dataTask = URLSession.shared.request(route: .notificationList, method: .post, parameters: nil, model: NotificationListModel.self) { result in
            switch result {
            case .success(let notificationsModel):
                self.notifications = notificationsModel.notifications.rows ?? []
                self.notifications.count == 0 ? self.tableView.setEmptyView("No Notification Found!") : self.tableView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }

}

extension NotificationListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NotificationTableViewCell = tableView.dequeueReusableCell(withIdentifier: "notification_cell_identifier") as! NotificationTableViewCell
        cell.notification = notifications[indexPath.row]
        return cell
    }
}
