//
//  ProfilePopUpViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/7/22.
//

import UIKit
import SVProgressHUD

class ProfilePopUpViewController: BaseViewController {

   private enum ApiType {
        case profile
        case unFollow
    }
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "FollowingTableViewCell", bundle: nil), forCellReuseIdentifier: FollowingTableViewCell.cellReuseIdentifier())
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.contentView.isHidden = false
            }
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var headerLabel: UILabel!
    
    var following: [FollowingRow] = [FollowingRow]()
    var follower: [FollowerRow] = [FollowerRow]()
    private var apiType: ApiType?
    var profileType: ProfileType?
    var connectionType: ConnectionType?
    
    var totalCount = 0
    var currentPage = 1
    var limit = 5
    
    var uuid: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(uuid ?? "")
        loadData()
    }
    
    private func loadData(){
        apiType = .profile
        if connectionType == .follower {
            headerLabel.text = "Followers"
            fetch(route: .follower, method: .post, parameters: ["page": currentPage, "limit": limit, "uuid": uuid ?? ""], model: FollowerModel.self)
        }
        else{
            headerLabel.text = "Following"
            fetch(route: .following, method: .post, parameters: ["page": currentPage, "limit": limit, "uuid": uuid ?? ""], model: FollowingModel.self)
        }
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type, cell: FollowingTableViewCell? = nil) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            
            switch result {
            case .success(let model):
                if self.apiType == .profile{
                    if self.connectionType == .following{
                        let followingModel = model as! FollowingModel
                        self.following.append(contentsOf: followingModel.chatUsers.rows)
                        self.totalCount = followingModel.chatUsers.count ?? 0
                        Helper.shared.tableViewHeight(tableView: self.tableView, tbHeight: self.tableViewHeight)
                    }
                    else{
                        let followerModel = model as! FollowerModel
                        self.follower.append(contentsOf: followerModel.followers?.rows ?? [])
                        self.totalCount = followerModel.followers?.count ?? 0
                        Helper.shared.tableViewHeight(tableView: self.tableView, tbHeight: self.tableViewHeight)
                    }
                }
                else{
                    let res = model as! SuccessModel
                    if res.success == false {
                        self.view.makeToast(res.message)
                    }
                    else{
                        if res.message == "Followed"{
                            cell?.followButton.setTitle("UNFollow", for: .normal)
                        }
                        else if res.message == "Unfollowed"{
                            cell?.followButton.setTitle("Follow", for: .normal)
                        }
                    }
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
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
            return self.following.count
        case .follower:
            return self.follower.count
        default:
           return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FollowingTableViewCell = tableView.dequeueReusableCell(withIdentifier: FollowingTableViewCell.cellReuseIdentifier()) as! FollowingTableViewCell
        if connectionType == .following{
            cell.following = following[indexPath.row]
        }
        else{
            cell.follower = follower[indexPath.row]
        }
        cell.followingButton.isHidden = profileType == .otherUser ? true : false
        cell.unfollowAction = {
            self.apiType = .unFollow
            if self.connectionType == .following{
                self.fetch(route: .doFollow, method: .post, parameters: ["uuid": self.following[indexPath.row].followerUser.uuid ?? ""], model: SuccessModel.self, cell: cell)
            }
            else{
                self.fetch(route: .doFollow, method: .post, parameters: ["uuid": self.follower[indexPath.row].followingUser.uuid ?? ""], model: SuccessModel.self, cell: cell)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if connectionType == .follower {
            print(follower.count, self.totalCount)
            if follower.count != totalCount && indexPath.row == follower.count - 1  {
                currentPage = currentPage + 1
                loadData()
            }
        }
        else if connectionType == .following{
            if following.count != totalCount && indexPath.row == following.count - 1  {
                currentPage = currentPage + 1
                loadData()
            }
        }
    }
}
