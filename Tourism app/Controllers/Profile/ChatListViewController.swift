//
//  ChatViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/6/22.
//

import UIKit
import SVProgressHUD
import SDWebImage
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
    var conversationUsers: [LoadedConversation]   = [LoadedConversation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadUsers), name: NSNotification.Name(rawValue: Constants.loadChatUser), object: nil)
        topBarView.addBottomShadow()
        tableView.keyboardDismissMode = .onDrag
        searchField.becomeFirstResponder()
        profileButton.sd_setBackgroundImage(with: URL(string: Helper.shared.getProfileImage()), for: .normal)
        load()
    }
    
    @objc func reloadUsers(){
        tableView.reloadData()
    }
    
    private func load(){
        fetch(route: .conversationUser, method: .post, parameters: ["search": searchField.text ?? ""], model: LoadedConversationModel.self)
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, showLoader: false, model: model) { result in
            switch result {
            case .success(let users):
                self.conversationUsers.append(contentsOf: (users as? LoadedConversationModel)?.userConversations ?? [])
                self.conversationUsers = self.conversationUsers.reversed()
                self.conversationUsers.count == 0 ? self.tableView.setEmptyView("No Record found!") : nil
                self.tableView.reloadData()
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
        var conversation = self.conversationUsers[indexPath.row]
        conversation.user?.unreadMessages = 0
        self.conversationUsers[indexPath.row] = conversation
        Switcher.goToChatVC(delegate: self, receiverUser1: conversation)
    }
}
