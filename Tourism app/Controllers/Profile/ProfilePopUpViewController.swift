//
//  ProfilePopUpViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/7/22.
//

import UIKit
import SVProgressHUD

class ProfilePopUpViewController: UIViewController {

   private enum ApiType {
        case profile
        case unFollow
    }
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "FollowingTableViewCell", bundle: nil), forCellReuseIdentifier: FollowingTableViewCell.cellReuseIdentifier())
        }
    }
    
    var following: [FollowingRow]?
    private var apiType: ApiType?
    var profileType: ProfileType?

    override func viewDidLoad() {
        super.viewDidLoad()
        apiType = .profile
        fetch(route: .following, method: .post, model: FollowingModel.self)
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let model):
                if self.apiType == .profile{
                    self.following = (model as! FollowingModel).chatUsers?.rows
                    self.following?.count != 0 ? self.tableView.reloadData() : self.tableView.setEmptyView()
                }
                else{
                    let res = model as! SuccessModel
                    SVProgressHUD.showSuccess(withStatus: res.message)
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension ProfilePopUpViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return following?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FollowingTableViewCell = tableView.dequeueReusableCell(withIdentifier: FollowingTableViewCell.cellReuseIdentifier()) as! FollowingTableViewCell
        cell.user = following?[indexPath.row]
        if profileType == .otherUser{
            cell.followingButton.isHidden = true
        }
        else{
            cell.followingButton.isHidden = false
        }
        cell.unfollowAction = {
            self.apiType = .unFollow
            self.fetch(route: .doFollow, method: .post, parameters: ["uuid": self.following?[indexPath.row].followingUser?.uuid ?? ""], model: SuccessModel.self)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}
