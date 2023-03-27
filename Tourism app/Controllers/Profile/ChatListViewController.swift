//
//  ChatViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/6/22.
//

import UIKit
import SVProgressHUD

class ChatListViewController: UIViewController {
    @IBOutlet weak var topBarView: UIView!

    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ChatListTableViewCell", bundle: nil), forCellReuseIdentifier: ChatListTableViewCell.cellReuseIdentifier())
        }
    }
    var conversationUsers: [UserConversation]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBarView.addBottomShadow()
        tableView.keyboardDismissMode = .onDrag
        searchField.becomeFirstResponder()
        searchField.addTarget(self, action: #selector(SearchUserViewController.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileButton.imageView?.sd_setImage(with: URL(string: Route.baseUrl + (UserDefaults.standard.profileImage ?? "")))
        load()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        load()
    }
    
    private func load(){
        fetch(route: .conversationUser, method: .post, parameters: ["search": searchField.text ?? ""], model: LoadedConversationModel.self)
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, showLoader: false, model: model) { result in
            switch result {
            case .success(let users):
                self.conversationUsers = (users as? LoadedConversationModel)?.userConversations
                self.tableView.reloadData()
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    @IBAction func gotoSearchBtnAction(_ sender: Any) {
        Switcher.gotoChatUserSearch(delegate: self)
    }
}

extension ChatListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversationUsers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChatListTableViewCell = tableView.dequeueReusableCell(withIdentifier: ChatListTableViewCell.cellReuseIdentifier()) as! ChatListTableViewCell
        if indexPath.row == 0{
            cell.statusIndicator.backgroundColor = Constants.onlineColor
        }
        else{
            cell.statusIndicator.backgroundColor = Constants.offlineColor
        }
        //cell.user = conversationUsers?[indexPath.row].user
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = conversationUsers?[indexPath.row].user else { return }
        //Switcher.goToChatVC(delegate: self, receiverUser: user)
    }
}
