//
//  ProfilePopUpViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/7/22.
//

import UIKit
import SVProgressHUD

class ProfilePopUpViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "FollowerTableViewCell", bundle: nil), forCellReuseIdentifier: FollowingTableViewCell.cellReuseIdentifier())
        }
    }
    
    var following: [FollowingRow]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFollowing(route: .following, method: .post, model: FollowingModel.self)
    }
    
    func fetchFollowing<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            print(result)
            switch result {
            case .success(let followings):
                self.following = (followings as! FollowingModel).chatUsers?.rows
                self.following?.count != 0 ? self.tableView.reloadData() : self.tableView.setEmptyView()
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}
