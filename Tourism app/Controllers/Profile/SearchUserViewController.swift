//
//  SearchUserViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/14/23.
//

import UIKit
import SDWebImage
import SVProgressHUD
class SearchChatUserTableViewCell: UITableViewCell {
    //
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    static let identifier = "cellID"
    
    var user: ChatUserRow?{
        didSet{
            nameLabel.text = user?.name
            profileImageView.sd_setImage(with: URL(string: Route.baseUrl + (user?.profileImage ?? "")), placeholderImage: UIImage(named: "user"))
        }
    }
    
}

class SearchUserViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var searchTF: UITextField!
    var chatUserModel: ChatUserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBarView.addBottomShadow()
        tableView.keyboardDismissMode = .onDrag
        searchTF.becomeFirstResponder()
        searchTF.addTarget(self, action: #selector(SearchUserViewController.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        fetch(route: .chatUser, method: .post, parameters: ["search": textField.text ?? ""], model: ChatUserModel.self)
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, showLoader: false, parameters: parameters, model: model) { result in
            switch result {
            case .success(let users):
                self.chatUserModel = users as? ChatUserModel
                if self.chatUserModel?.chatUsers?.rows?.count == 0{
                    self.tableView.setEmptyView("No search found!")
                }
                else{
                    self.tableView.backgroundView = nil
                    self.tableView.reloadData()
                }
//                self.chatUserModel?.chatUsers.rows.count == 0 ? self.tableView.setEmptyView() : self.tableView.reloadData()
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension SearchUserViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatUserModel?.chatUsers?.rows?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchChatUserTableViewCell = tableView.dequeueReusableCell(withIdentifier: SearchChatUserTableViewCell.identifier) as! SearchChatUserTableViewCell
        cell.user = chatUserModel?.chatUsers?.rows?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(chatUserModel?.chatUsers.rows[indexPath.row])
//        guard let user = chatUserModel?.chatUsers.rows[indexPath.row] else { return }
        Switcher.goToChatVC(delegate: self, receiverUser: (chatUserModel?.chatUsers?.rows?[indexPath.row])!)
    }
}
