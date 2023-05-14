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
    var follower: [FollowerRow]?
    private var apiType: ApiType?
    var profileType: ProfileType?
    var connectionType: ConnectionType?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiType = .profile
        if connectionType == .follower {
            fetch(route: .follower, method: .post, model: FollowerModel.self)
        }
        else{
            fetch(route: .following, method: .post, model: FollowingModel.self)
        }
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type, cell: FollowingTableViewCell? = nil) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let model):
                if self.apiType == .profile{
                    if self.connectionType == .following{
                        self.following = (model as! FollowingModel).chatUsers.rows
                        self.following?.count != 0 ? self.tableView.reloadData() : self.tableView.setEmptyView("No Following Found!")
                    }
                    else{
                        self.follower = (model as! FollowerModel).followers.rows
                        self.follower?.count != 0 ? self.tableView.reloadData() : self.tableView.setEmptyView("No Follower Found!")
                    }
                }
                else{
                    let res = model as! SuccessModel
                    if res.message == "Followed"{
                        cell?.followingButton.setTitle("UNFollow", for: .normal)
                    }
                    else if res.message == "Unfollowed"{
                        cell?.followingButton.setTitle("Follow", for: .normal)
                    }
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
        switch connectionType {
        case .following:
            return self.following?.count ?? 0
        case .follower:
            return self.follower?.count ?? 0
        default:
           return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FollowingTableViewCell = tableView.dequeueReusableCell(withIdentifier: FollowingTableViewCell.cellReuseIdentifier()) as! FollowingTableViewCell
        if connectionType == .following{
            cell.following = following?[indexPath.row]
        }
        else{
            cell.follower = follower?[indexPath.row]
        }
        
        if profileType == .otherUser{
            cell.followingButton.isHidden = true
        }
        else{
            cell.followingButton.isHidden = false
        }
        cell.unfollowAction = {
            self.apiType = .unFollow
            if self.connectionType == .following{
                self.fetch(route: .doFollow, method: .post, parameters: ["uuid": self.following?[indexPath.row].followerUser.uuid ?? ""], model: SuccessModel.self, cell: cell)
            }
            else{
                self.fetch(route: .doFollow, method: .post, parameters: ["uuid": self.follower?[indexPath.row].followerUser.uuid ?? ""], model: SuccessModel.self, cell: cell)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
}
