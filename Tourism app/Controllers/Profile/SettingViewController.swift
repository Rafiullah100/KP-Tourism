//
//  SettingViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/12/22.
//

import UIKit
import SVProgressHUD
class SettingTableViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var label: UILabel!
    static let identifier = "setting_cell_identifier"
}

struct Settings {
    let image: String?
    let title: String?
}

class SettingViewController: BaseViewController {

    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    var settings: [Settings]? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBarView.addBottomShadow()
        settings = [Settings(image: "setting-personal", title: "Personal Information"), Settings(image: "setting-seller", title: "Become a Seller"), Settings(image: "setting-tourist", title: "Become a Tourist"), Settings(image: "planner-gray", title: "Tour Planner"), Settings(image: "setting-notification", title: "Notification"), Settings(image: "setting-security", title: "Security"), Settings(image: "setting-help", title: "Help"), Settings(image: "delete-account", title: "Deactivate Account")]
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    func deleteAccount() {
        dataTask = URLSession.shared.request(route: .deleteProfile, method: .post, parameters: nil, model: SuccessModel.self) { result in
            switch result {
            case .success(let delete):
                if delete.success == true {
                    self.view.makeToast(delete.message)
                    Helper.shared.logoutUser(self: self)
                }
                else{
                    self.view.makeToast(delete.message)
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier) as! SettingTableViewCell
        cell.imgView.image = UIImage(named: settings?[indexPath.row].image ?? "")
        cell.label.text = settings?[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 5:
            Switcher.goToSecurityVC(delegate: self)
        case 1:
            Switcher.goToSellerVC(delegate: self, userType: .seller)
        case 2:
            Switcher.goToSellerVC(delegate: self, userType: .tourist)
        case 0:
            Switcher.goToPersonalInfoVC(delegate: self)
        case 3:
            Switcher.goToPlannerVC(delegate: self)
        case 4:
            Switcher.gotoNotificationListVC(delegate: self)
        case 7:
            Utility.showAlert(message: "Are you sure you want to delete your account?", buttonTitles: ["cancel", "Yes"]) { response in
                if response == "Yes"{
                    self.deleteAccount()
                }
            }
        default:
            break
        }
    }
}
