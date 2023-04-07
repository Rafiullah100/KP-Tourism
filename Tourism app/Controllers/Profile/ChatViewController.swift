//
//  ChatViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/12/22.
//

import UIKit
import SDWebImage
import SVProgressHUD
import SocketIO
import IQKeyboardManager
class CellIds {
    static let senderCellId = "senderCellId"
    static let receiverCellId = "receiverCellId"
}

class ChatViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var toolBarView: UIView!
    @IBOutlet weak var topBarView: UIView!

    @IBOutlet weak var recieverProfileImage: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: CellIds.receiverCellId)
            tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: CellIds.senderCellId)
        }
    }
    
//    private lazy var keyboardView: KeyboardInputAccessoryView = {
//        return KeyboardInputAccessoryView.view(controller: self)
//    }()
//    override var inputAccessoryView: UIView? {
//        return keyboardView.canBecomeFirstResponder ? keyboardView : nil
//    }
//    override var canBecomeFirstResponder: Bool {
//        return keyboardView.canBecomeFirstResponder
//    }
    
    var chatUser: ChatUserRow?
    var conversation: [OnetoOneConversationRow]?
    var chatUser1: LoadedConversation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        IQKeyboardManager.shared().isEnableAutoToolbar = false
//        textView.inputAccessoryView = UIView()

        topBarView.addBottomShadow()
    }
    
    @IBAction func showkeyboardBtn(_ sender: Any) {
//        self.keyboardView.showKeyboard()
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        keyboardView.inputTextView.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if chatUser != nil {
            nameLabel.text = chatUser?.name
            recieverProfileImage.sd_setImage(with: URL(string: Route.baseUrl + (chatUser?.profileImage ?? "")), placeholderImage: UIImage(named: "user"))
            fetch(route: .onetoOneConversation, method: .post, parameters: ["uuid": chatUser?.uuid ?? ""], model: OnetoOneConversationModel.self)
        }
        else{
            nameLabel.text = chatUser1?.user?.name
            recieverProfileImage.sd_setImage(with: URL(string: Route.baseUrl + (chatUser1?.user?.profileImage ?? "")), placeholderImage: UIImage(named: "user"))
            fetch(route: .onetoOneConversation, method: .post, parameters: ["uuid": chatUser1?.user?.uuid ?? ""], model: OnetoOneConversationModel.self)
        }
        
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, showLoader: false, parameters: parameters, model: model) { result in
            switch result {
            case .success(let conversation):
                self.conversation = (conversation as? OnetoOneConversationModel)?.chats.rows ?? []
                self.conversation?.count == 0 ? self.tableView.setEmptyView("No previous conversation exist!") : self.tableView.reloadData()
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    func sendMessage<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let message):
                let success = message as? SuccessModel
                SVProgressHUD.showSuccess(withStatus: success?.message)
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.conversation?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if conversation?[indexPath.row].sender.id == UserDefaults.standard.userID{
            guard let cell: ChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIds.receiverCellId, for: indexPath) as? ChatTableViewCell else { return UITableViewCell() }
            cell.textView.text = conversation?[indexPath.section].content
            cell.bottomLabel.text = conversation?[indexPath.row].createdAt
            return cell
        }
        else{
            guard let cell: ChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIds.senderCellId, for: indexPath) as? ChatTableViewCell else { return UITableViewCell() }
            cell.textView.text = conversation?[indexPath.section].content
            cell.bottomLabel.text = conversation?[indexPath.row].createdAt
            return cell
        }
    }
}

extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ChatViewController: KeyboardInputAccessoryViewProtocol{
//    func scrollView() -> UIScrollView {
//        return UIScrollView()
//    }
    
    func send(data type: String) {
        if chatUser != nil{
            sendMessage(route: .messageAPI, method: .post, parameters: ["message": type, "conversation_id": chatUser?.id ?? "", "uuid": chatUser?.uuid ?? ""], model: SuccessModel.self)
        }
        else{
            SocketHelper.shared.sendMessage(message: "message", withNickname: "name")
//            sendMessage(route: .messageAPI, method: .post, parameters: ["message": type, "conversation_id": chatUser1?.conversationID ?? "", "uuid": chatUser1?.user?.uuid ?? ""], model: SuccessModel.self)
        }
//        doComment(route: .doComment, method: .post, parameters: ["blog_id": blogDetail?.id ?? "", "comment": type], model: SuccessModel.self)
    }
    
    
//    func send(textView: UITextView) {
//        commentTextView.resignFirstResponder()
//        textView.resignFirstResponder()
//        commentView.isHidden = false
////        doComment(route: .doComment, method: .post, parameters: ["blog_id": blogDetail?.id ?? "", "comment": type], model: SuccessModel.self)
//    }
    
    
    
}
