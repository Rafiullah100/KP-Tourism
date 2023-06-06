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
//    var conversationUsers: [LoadedConversation]?
    var conversationUsers: [LoadedConversation]   = [LoadedConversation]()
    var limit = 10
    var currentPage = 1
    var totalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBarView.addBottomShadow()
        tableView.keyboardDismissMode = .onDrag
        searchField.becomeFirstResponder()
        
//        profileButton.sd_setImage(with: URL(string: Helper.shared.getProfileImage()), for: .normal)
        searchField.addTarget(self, action: #selector(SearchUserViewController.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileButton.imageView?.sd_setImage(with: URL(string: Route.baseUrl + (UserDefaults.standard.profileImage ?? "")))
        currentPage = 1
        totalCount = 0
        conversationUsers = []
        load()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        load()
    }
    
    private func load(){
        fetch(route: .conversationUser, method: .post, parameters: ["search": searchField.text ?? "", "limit": limit, "page": currentPage], model: LoadedConversationModel.self)
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, showLoader: false, model: model) { result in
            switch result {
            case .success(let users):
//                self.conversationUsers = (users as? LoadedConversationModel)?.userConversations ?? []
                self.conversationUsers.append(contentsOf: (users as? LoadedConversationModel)?.userConversations ?? [])
                self.totalCount = (users as? LoadedConversationModel)?.count ?? 0
                self.conversationUsers.count == 0 ? self.tableView.setEmptyView("No Record found!") : self.tableView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    @IBAction func gotoSearchBtnAction(_ sender: Any) {
        Switcher.gotoChatUserSearch(delegate: self)
    }
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension ChatListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversationUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChatListTableViewCell = tableView.dequeueReusableCell(withIdentifier: ChatListTableViewCell.cellReuseIdentifier()) as! ChatListTableViewCell
        cell.user = conversationUsers[indexPath.row].user
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let conversation = self.conversationUsers[indexPath.row]
        Switcher.goToChatVC(delegate: self, receiverUser1: conversation)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(conversationUsers.count, totalCount, indexPath.row)
        if conversationUsers.count != totalCount && indexPath.row == conversationUsers.count - 1  {
            currentPage = currentPage + 1
            load()
        }
    }
}
