//
//  ChatViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/6/22.
//

import UIKit
import SVProgressHUD
import SDWebImage
class ChatListViewController: BaseViewController {
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
        fetch(parameters: ["search": searchField.text ?? ""])
    }
    
    func fetch(parameters: [String: Any]) {
        URLSession.shared.request(route: .conversationUser, method: .post, showLoader: false, model: LoadedConversationModel.self) { result in
            switch result {
            case .success(let users):
                self.conversationUsers.append(contentsOf: (users.userConversations ?? []))
                self.conversationUsers = self.conversationUsers.reversed()
                self.conversationUsers.count == 0 ? self.tableView.setEmptyView("No Record found!") : nil
                self.tableView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    func deleteConversation(parameters: [String: Any], index: Int) {
        URLSession.shared.request(route: .deleteConversation, method: .post, showLoader: true, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let res):
                if res.success == true{
                    self.conversationUsers.remove(at: index)
                    self.tableView.reloadData()
                }
                self.view.makeToast(res.message ?? "")
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
        cell.deleteHandler = {
            Utility.showAlert(message: "Do you want to delete conversation?", buttonTitles: ["No", "Yes"]) { responce in
                if responce == "Yes"{
                    guard let conversationID = self.conversationUsers[indexPath.row].conversationID else { return }
                    self.deleteConversation(parameters: ["conversation_id": conversationID], index: indexPath.row)
                }
            }
        }
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
